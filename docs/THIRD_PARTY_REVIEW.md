# Third-party distribution and license review

Reviewed at exact locked revisions on 2026-10-30. Dependency source trees and
compiled artifacts are not part of the release ZIP. The root license evidence
below is an inventory, not a relicensing of those dependencies.

| Dependency | Root license | Exact revision | Evidence |
|---|---|---|---|
| mathlib | Apache-2.0 | `c44e0c8ee63ca166450922a373c7409c5d26b00b` | [LICENSE](https://github.com/leanprover-community/mathlib4/blob/c44e0c8ee63ca166450922a373c7409c5d26b00b/LICENSE) |
| plausible | Apache-2.0 | `77e08eddc486491d7b9e470926b3dbe50319451a` | [LICENSE](https://github.com/leanprover-community/plausible/blob/77e08eddc486491d7b9e470926b3dbe50319451a/LICENSE) |
| LeanSearchClient | Apache-2.0 | `25078369972d295301f5a1e53c3e5850cf6d9d4c` | [LICENSE](https://github.com/leanprover-community/LeanSearchClient/blob/25078369972d295301f5a1e53c3e5850cf6d9d4c/LICENSE) |
| importGraph | Apache-2.0 | `e6a9f0f5ee3ccf7443a0070f92b62f8db12ae82b` | [LICENSE](https://github.com/leanprover-community/import-graph/blob/e6a9f0f5ee3ccf7443a0070f92b62f8db12ae82b/LICENSE) |
| proofwidgets | Apache-2.0 | `c4919189477c3221e6a204008998b0d724f49904` | [LICENSE](https://github.com/leanprover-community/ProofWidgets4/blob/c4919189477c3221e6a204008998b0d724f49904/LICENSE) |
| aesop | Apache-2.0 | `5d50b08dedd7d69b3d9b3176e0d58a23af228884` | [LICENSE](https://github.com/leanprover-community/aesop/blob/5d50b08dedd7d69b3d9b3176e0d58a23af228884/LICENSE) |
| Qq | Apache-2.0 | `fa4f7f15d97591a9cf3aa7724ba371c7fc6dda02` | [LICENSE](https://github.com/leanprover-community/quote4/blob/fa4f7f15d97591a9cf3aa7724ba371c7fc6dda02/LICENSE) |
| batteries | Apache-2.0 | `f5d04a9c4973d401c8c92500711518f7c656f034` | [LICENSE](https://github.com/leanprover-community/batteries/blob/f5d04a9c4973d401c8c92500711518f7c656f034/LICENSE) |
| Cli | MIT | `02dbd02bc00ec4916e99b04b2245b30200e200d0` | [LICENSE](https://github.com/leanprover/lean4-cli/blob/02dbd02bc00ec4916e99b04b2245b30200e200d0/LICENSE) |

The official Lean 4.19.0 distribution has an Apache-2.0 root LICENSE, with
other bundled runtime components retaining their own terms. No Lean distribution
content or binary is redistributed in this source package.

Distributed license text includes the unmodified official Apache-2.0 license
in the repository root `LICENSE`.
OEIS identifiers, links, recurrence statements and scholarly credit are
references and mathematical facts; no OEIS page text, manuscript or image is
bundled. The original project source files contain no identified third-party
copyright/license headers or copying notices. Imported Mathlib theorems are
external dependencies, not vendored Mathlib files.

Original package scripts, C shim, documentation, contract, source manifests and
Lean-generated inspection output are covered by the approved original-material
license where rights are held. AI assistance is disclosed in AUTHORS.md. No per-line
originality determination or legal clearance is claimed.

No upstream dependency NOTICE is bundled because no dependency source/binary
is redistributed. If that scope changes, examine all component and file-level
licenses and notices before distributing them. Do not assume that the root
license inventories alone clear a compiler binary or an entire dependency tree.
