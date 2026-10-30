# Build and independent reproduction

## Requirements and pins

Use a fresh ZIP extraction with no `.lake`, `.olean`, `.git`, or copied project
build outputs. For a fresh Git checkout, Git metadata is permitted and omit
`--pristine` from the manual checks; no project build outputs may be reused. Install Git, Python 3.9+, Bash, and Elan/Lean using the official
[Elan installation instructions](https://github.com/leanprover/elan#installation).
Run commands from the package root, not from `Pisot/`.

- `lean-toolchain`: `leanprover/lean4:v4.19.0`.
- Expected Lean compiler commit: `6caaee842e94`.
- Expected Lake: `5.0.0-6caaee8`.
- Mathlib: `c44e0c8ee63ca166450922a373c7409c5d26b00b`.
- The unchanged `lake-manifest.json` locks all nine dependency Git revisions.

Public network access is needed for the Lean toolchain, pinned Git sources,
and Mathlib caches. This source-only ZIP intentionally contains none of those
downloaded sources or binaries. It needs no private GitHub credentials.
Transitive `inputRev` labels such as `main` are historical resolution inputs;
the manifest's exact `rev` hashes are the pinned resolutions. Do not run
`lake update`, delete the manifest, or substitute newer releases.

## Automated procedure

```sh
bash scripts/reproduce.sh
```

This convenience script checks a pristine source ZIP or a clean Git checkout, creates a unique
external log directory, checks version strings, retrieves dependency caches,
checks dependency HEADs and tracked cleanliness, then builds all original
modules and executes the extracted M6 audit. Bash `pipefail` preserves failures
through `tee`. A final success message is reached only after every command
returns successfully. The script works on a ZIP extraction or a Git checkout. Mission 2 executed
the manual Lake route successfully; the exact Mission 3 checks are recorded
in its companion report. Do not interpret wrapper syntax validation as a build.

## Manual procedure

Run each command in order and stop on a nonzero exit status:

```sh
python3 scripts/verify_package.py   # add --pristine for a ZIP extraction
test ! -e .lake
lean --version
lake --version
lake exe cache get
test ! -e .lake/build
python3 scripts/verify_package.py --dependencies
lake build
lake env lean audit/M6FinalAudit.lean
lake env lean audit/ReleaseStatementAudit.lean
python3 scripts/verify_package.py --dependencies
```

Capture stdout/stderr outside the package and record each actual exit code.
For a separately saved audit log, run:

```sh
python3 scripts/verify_package.py --audit-output /absolute/path/to/new-lean-audit.log
```

This parser checks the 82 axiom records and expected foundation sets. It does
not prove where a log came from or whether Lean exited 0; the runner must record
that. The original `Pisot.lean` default target imports all 22 original modules,
including 11 milestone audit modules. The extracted `audit/M6FinalAudit.lean`
is an additional inspection file executed explicitly, not a new default target.

Require the two final types in the technical summary, exact n≥6 bounds and
integer arithmetic, and final axiom closures exactly
`[propext, Classical.choice, Quot.sound]`. Review diagnostics rather than
treating a visible PASS word in an old log as a new result. For a second fresh
test, extract the original ZIP again; the pristine runner intentionally refuses
an existing `.lake` tree.

## Optional Linux container workaround

Ordinary Linux requires no shim. Historical M6 observed a compiler startup
failure when `/proc/<own-pid>/exe` was denied but `/proc/self/exe` worked.
Only if that specific issue is reproduced, compile the unchanged source:

```sh
pisot_shim_dir="$(mktemp -d)"
cc -shared -fPIC scripts/self-exe.c -ldl -o "$pisot_shim_dir/pisot-self-exe.so"
export LD_PRELOAD="$pisot_shim_dir/pisot-self-exe.so"
export TAR_OPTIONS=--no-same-owner
bash scripts/reproduce.sh
```

The wrapper redirects that executable-path lookup. It does not replace the Lean
binary or mathematical sources. Record its use; prefer normal execution when
possible. No compiled shim is shipped. The recorded M6 Linux `bin/lean` SHA-256
is `92c3d35b5bfaa5e0fea413a775d504cf46cd95e1345df61c2274f76779e7e023`;
this is platform-specific historical evidence, not a universal binary hash.

## A stronger optional dependency check

Standard reproduction uses the public Mathlib cache, as M6 did. A reviewer who
wants to reduce reliance on cached compiled dependencies can build the pinned
dependency sources locally in a separate fresh environment. That more expensive
check has not been performed or claimed for this package.

## Restoring shallow dependency checkouts

Lake normally obtains locked dependencies itself. If an environment requires
manual shallow recovery, fetch each exact `rev` in `lake-manifest.json` and check
its detached HEAD. For ProofWidgets also fetch its matching release tag:

```sh
git -C .lake/packages/proofwidgets fetch --depth 1 origin tag v0.0.57
lake exe cache get
```

The tag lookup addresses cloud-release discovery without changing the pinned
checkout. Verify every dependency HEAD and clean tracked status afterward.
