#!/usr/bin/env bash
# Run from a fresh extracted source package. Logs are kept outside it.
set -euo pipefail
root="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$root"
if [ -d .git ]; then
  python3 scripts/verify_package.py
else
  python3 scripts/verify_package.py --pristine
fi
for tool in lean lake git; do
  if ! command -v "$tool" >/dev/null; then
    printf 'Missing required tool: %s. No Lean build has run. See docs/BUILD.md.\n' "$tool" >&2
    exit 1
  fi
done
test ! -e .lake
run_dir="$(mktemp -d "${TMPDIR:-/tmp}/pisot-release-test.XXXXXX")"
printf 'Verification logs: %s\n' "$run_dir"
lean --version | tee "$run_dir/lean-version.txt"
lake --version | tee "$run_dir/lake-version.txt"
grep -q 'version 4.19.0' "$run_dir/lean-version.txt"
grep -q '5.0.0-6caaee8' "$run_dir/lake-version.txt"
lake exe cache get 2>&1 | tee "$run_dir/dependency-cache.log"
test ! -e .lake/build
python3 scripts/verify_package.py --dependencies | tee "$run_dir/pre-build-checks.log"
lake build 2>&1 | tee "$run_dir/lake-build.log"
lake env lean audit/M6FinalAudit.lean 2>&1 | tee "$run_dir/lean-audit.log"
python3 scripts/verify_package.py --dependencies --audit-output "$run_dir/lean-audit.log" | tee "$run_dir/post-build-checks.log"
printf 'RELEASE BUILD AND AUDIT PASSED. Logs: %s\n' "$run_dir"
