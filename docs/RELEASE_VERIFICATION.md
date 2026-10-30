# Verification status of the source release

The original mathematical Lean project contains 22 modules. Mission 3 (2026-10-30) independently rebuilt the 55-file prepublication candidate from a fresh extraction with Lean 4.19.0, pinned Mathlib and dependencies: `lake build` exited 0, 22 modules compiled, 82 theorem/axiom closures were checked and 16 explicit theorem-type checks passed. The original M6 and Mission 2 runs also passed.

This public source release preserves all 27 M6 sources/configuration/contract files byte for byte. Publication-only changes activate the approved Apache-2.0 license, attribution/citation metadata, repository naming and documentation, and improve the convenience script's Git checkout handling. Its own source integrity is independently verified by `python3 scripts/verify_package.py`.

**Do not represent the Mission 3 build as a new build performed on this exact subsequent publication ZIP.** To verify the released version, run the commands in [BUILD.md](BUILD.md) from a clean clone or extraction. The original Lean sources and imports remain unchanged. This package does not include compiler binaries, `.olean` files or dependency source trees.

The two final original-sequence recurrence theorems are `Pisot.A048590_fifth_rec` and `Pisot.A048592_fifth_rec` for all natural `n >= 6`. Both depend only on Lean's conventional foundations `propext`, `Classical.choice` and `Quot.sound`. This is kernel verification, not independent human peer review.
