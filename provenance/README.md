# Source and verification provenance

This source release was prepared on 2026-10-30 from a read-only retrieval at final
M6 documentation commit `6ea11cf7905a4759dc34817109daf1a6fce07075`. The source branch
`formalization/lean4-matrix` was identical to that commit when compared.
The mathematical source tested by M6 is `a37dfa299f63b8cbd753a9dc787a1cf61b02b50c`,
with tree `87e3140bdfdadf1e478ff1b0a357b0746152ae81`.

The comparison from the tested commit to M6 has exactly four changed paths:
`lean/FINAL_VERIFICATION_REPORT.md`, `lean/STATUS.md`,
`lean/logs/M6-clean-build.log`, `lean/logs/M6-final-audit.log`.
No mathematical source or pin differs. Retrieval made no repository mutations.

## Included evidence

- `source-comparison.json`: all 27 preserved files, original/private-tree path,
  release path, Git blob SHA-1, expected M6 SHA-256, observed SHA-256 and match.
  This includes 22 project modules, three configuration files, the optional
  C shim, and the original contract. Every retained file matches.
- `M6-source-manifest-original.sha256`: the 31 source-manifest lines extracted
  from the M6 report. Historical manuscript/handoff/script entries are retained
  as manifest text only; those four files are not in this release and are not
  needed by Lean. Use `source-comparison.json` for paths present in this package.
  The original-path manifest is provenance, not a release-root `sha256sum -c` file.
- `../audit/M6FinalAudit.lean`: exact input extracted from the M6 audit log.
  This adds no proof declarations. It checks 82 public theorems, prints 15
  definitions and includes 8 explicit type ascriptions.
- `M6-lean-audit-output.txt`: historical Lean output from M6, not a new run.
  The original timestamp/absolute-command prefix and runner's exit-code footer
  were omitted. All remaining excerpt bytes are preserved; extraction details
  and checksums are in `provenance.json`.
- `import-graph.json`: graph generated from the retained source imports.
- `package.sha256`: full release payload hashes, excluding only itself to avoid
  a self-hash cycle. The outer ZIP checksum is delivered separately.

The complete raw M6 report, clean-build log, final-audit log, original README,
status history and formalization contract were retrieved and inspected during
preparation. Their Git blob/SHA-256 identities are recorded in `provenance.json`.
The two complete log hashes agree with the M6 report:

```text
ded77124f87f87b8e8130cb1f78f199f22d859ed1e8be20358dcbcdaf321c709  M6-clean-build.log
18e12a4e0c97ca3e13118105ac7fdce7d5dcf11ff7c031c02f4ecbc6bc4baedb  M6-final-audit.log
```

The raw report/logs are not redistributed: they contain private-tree/workspace
context unnecessary for reproducing the mathematics. The complete proof sources,
pins, audit input, and research summary are supplied instead. The original
repository identifier and personal contact details are omitted from the
distributable snapshot; immutable commit IDs and original source paths provide
traceability without embedding private Git history. Without access to that
private repository, an external researcher can check internal byte consistency
and rebuild the proof, but cannot independently authenticate the historical
Git provenance solely from the ZIP.

Historical M6 recorded clean build exit 0 and audit exit 0. Mission 2 then
successfully rebuilt the original standalone ZIP and repeated the full audit.
Mission 3 refreshed the publication documents and built its prepublication
candidate. This published source tree preserves the 27 M6 files and carries
additional final licensing and metadata edits. `package.sha256` covers this
release tree (excluding the manifest itself), not the earlier Mission 1 ZIP.
