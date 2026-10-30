#!/usr/bin/env python3
"""Read-only package checks; not a Lean proof checker. Python 3.9+ standard library."""
import argparse
import collections
import hashlib
import json
from pathlib import Path
import re
import subprocess

ROOT = Path(__file__).resolve().parents[1]


def require(condition, message):
    if not condition:
        raise SystemExit('FAIL: ' + message)


def uncomment(s):
    """Remove nested Lean comments and strings, preserving line positions."""
    out = list(s)
    i = depth = 0
    string = False
    while i < len(s):
        if depth:
            if s.startswith('/-', i):
                out[i:i+2] = '  '; depth += 1; i += 2
            elif s.startswith('-/', i):
                out[i:i+2] = '  '; depth -= 1; i += 2
            else:
                if s[i] != '\n': out[i] = ' '
                i += 1
        elif string:
            if s[i] == '\\' and i+1 < len(s):
                out[i:i+2] = '  '; i += 2
            elif s[i] == '"':
                out[i] = ' '; string = False; i += 1
            else:
                if s[i] != '\n': out[i] = ' '
                i += 1
        elif s.startswith('/-', i):
            out[i:i+2] = '  '; depth = 1; i += 2
        elif s.startswith('--', i):
            end = s.find('\n', i)
            if end < 0: end = len(s)
            out[i:end] = ' ' * (end-i); i = end
        elif s[i] == '"':
            out[i] = ' '; string = True; i += 1
        else:
            i += 1
    require(not depth and not string, 'unterminated Lean comment/string')
    return ''.join(out)


def source_checks():
    rows = json.loads((ROOT/'provenance/source-comparison.json').read_text())
    require(len(rows) == 27, 'expected 27 preserved files')
    for row in rows:
        b = (ROOT/row['release_path']).read_bytes()
        h = hashlib.sha256(b).hexdigest()
        require(h == row['m6_sha256'] == row['release_sha256'], row['release_path'])
        git_h = hashlib.sha1(b'blob '+str(len(b)).encode()+b'\0'+b).hexdigest()
        require(git_h == row['git_blob_sha1'], 'Git blob mismatch: '+row['release_path'])
    files = [ROOT/'Pisot.lean', *sorted((ROOT/'Pisot').glob('*.lean'))]
    require(len(files) == 22, 'expected 22 original Lean modules')
    imports, names = {}, []
    patterns = [
        r'\b(?:sorry|admit|sorryAx|axiom|unsafe|native_decide|native_decide_core|implemented_by|extern)\b',
        r'#(?:eval|reduce)\b',
        r'\b(?:set_option|elab|elab_rules|macro|macro_rules|run_tac|run_elab|declare_syntax_cat)\b',
        r'^\s*(?:variable|variables|parameter|parameters)\b',
        r'^\s*(?:noncomputable\s+)?(?:instance|opaque)\b',
        r'^\s*(?:local\s+|scoped\s+)?(?:notation|syntax|infixl?|infixr|prefix|postfix)\b',
    ]
    for path in files:
        code = uncomment(path.read_text())
        mod = '.'.join(path.relative_to(ROOT).with_suffix('').parts)
        imports[mod] = re.findall(r'^import\s+(\S+)', code, re.M)
        for pattern in patterns:
            require(not re.search(pattern, code, re.M), 'prohibited construct in '+mod)
        names.extend('Pisot.'+n for n in re.findall(r'^(?:@\[[^\n]*\]\s*)?(?:theorem|lemma)\s+(\w+)', code, re.M))
    visited, active = set(), set()
    def visit(mod):
        require(mod not in active, 'cyclic imports')
        if mod in visited: return
        active.add(mod)
        for dep in imports[mod]:
            if dep.startswith('Pisot'):
                require(dep in imports, 'missing module '+dep)
                visit(dep)
            else:
                require(dep == 'Mathlib', 'unexpected external import '+dep)
        active.remove(mod); visited.add(mod)
    visit('Pisot')
    require(visited == set(imports), 'unreachable module')
    require(len(names) == len(set(names)) == 82, 'expected 82 public theorem constants')
    audit = (ROOT/'audit/M6FinalAudit.lean').read_text()
    checks = re.findall(r'^#check (Pisot\.\w+)\s*$', audit, re.M)
    axioms = re.findall(r'^#print axioms (Pisot\.\w+)\s*$', audit, re.M)
    require(sorted(names) == sorted(checks) == sorted(axioms), 'M6 audit coverage mismatch')
    require(len(re.findall(r'^#check \(', audit, re.M)) == 8, 'expected 8 explicit type checks')
    require(len(re.findall(r'^#print Pisot\.', audit, re.M)) == 15, 'expected 15 definition prints')
    require(not re.search(r'\b(?:def|theorem|lemma|axiom|example|set_option|unsafe)\b', uncomment(audit)), 'audit must add no declarations')
    print('PASS: 27 M6 byte comparisons; 22-module acyclic closure; source scan; 82 theorem audit coverage; 15 definitions; 8 explicit type checks')
    return set(names)


def verify_output(path, names, label):
    output = path.read_text()
    require(not re.search(r'\b(?:error|warning):', output), label+' contains diagnostics')
    found = {}
    for name, values in re.findall(r"'(Pisot\.\w+)' depends on axioms: \[([^\]]*)\]", output):
        require(name not in found, 'duplicate axiom record: '+name)
        found[name] = sorted(x.strip() for x in values.split(',') if x.strip())
    for name in re.findall(r"'(Pisot\.\w+)' does not depend on any axioms", output):
        require(name not in found, 'duplicate axiom record: '+name)
        found[name] = []
    require(set(found) == names, label+' axiom coverage mismatch')
    allowed = {'propext', 'Classical.choice', 'Quot.sound'}
    require(all(set(v) <= allowed for v in found.values()), label+' unexpected axiom')
    for name in ['A048590_fifth_rec','A048592_fifth_rec']:
        require(set(found['Pisot.'+name]) == allowed, name+' axiom set changed')
    counts = collections.Counter(tuple(v) for v in found.values())
    require(sorted(counts.values()) == [4,5,7,66], label+' axiom distribution changed')
    print('PASS: '+label+'; 82 axiom records, expected distribution 66/4/5/7')


def payload_checks(pristine):
    manifest = ROOT/'provenance/package.sha256'
    require(manifest.is_file(), 'missing package hash manifest')
    expected = set()
    for line in manifest.read_text().splitlines():
        h, p = line.split('  ', 1)
        require(not Path(p).is_absolute() and '..' not in Path(p).parts, 'unsafe manifest path')
        target = ROOT/p
        require(not target.is_symlink(), 'symlink '+p)
        require(hashlib.sha256(target.read_bytes()).hexdigest() == h, 'payload mismatch '+p)
        expected.add(p)
    if pristine:
        actual = {str(p.relative_to(ROOT)) for p in ROOT.rglob('*') if p.is_file()}
        require(actual == expected | {'provenance/package.sha256'}, 'unexpected or missing files in fresh package')
        require(not any(p.is_symlink() for p in ROOT.rglob('*')), 'symlink in package')
        for p in ROOT.rglob('*'):
            require(p.name not in {'.git','.lake','__pycache__','.env'}, 'build/history/private artifact '+str(p.relative_to(ROOT)))
    print('PASS: full payload SHA-256'+('; exact pristine inventory' if pristine else ''))


def dependencies():
    for p in json.loads((ROOT/'lake-manifest.json').read_text())['packages']:
        cwd = ROOT/'.lake/packages'/p['name']
        require((cwd/'.git').exists(), 'missing dependency checkout '+p['name'])
        head = subprocess.check_output(['git','rev-parse','HEAD'],cwd=cwd,text=True).strip()
        status = subprocess.check_output(['git','status','--porcelain','--untracked-files=no'],cwd=cwd,text=True)
        require(head == p['rev'] and not status, 'dependency pin or tracked-source mismatch '+p['name'])
    print('PASS: nine dependency HEADs and clean tracked sources match lockfile')


def main():
    ap = argparse.ArgumentParser(description=__doc__)
    ap.add_argument('--pristine', action='store_true', help='also reject extra files/history/build products')
    ap.add_argument('--dependencies', action='store_true', help='check installed dependency revisions')
    ap.add_argument('--audit-output', type=Path, help='check a separately executed Lean audit log; does not prove its origin or exit status')
    args = ap.parse_args()
    payload_checks(args.pristine)
    names = source_checks()
    verify_output(ROOT/'provenance/M6-lean-audit-output.txt', names, 'HISTORICAL M6 output, not a new Lean run')
    if args.dependencies: dependencies()
    if args.audit_output: verify_output(args.audit_output, names, 'supplied audit output; caller must verify Lean exit 0')
    print('PACKAGE CHECKS PASSED. These checks do not execute Lean or establish a new kernel verification.')


if __name__ == '__main__':
    main()
