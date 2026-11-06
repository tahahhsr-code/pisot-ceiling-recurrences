# Pisot ceiling recurrences — Lean 4 formal verification

[![License: Apache-2.0](https://img.shields.io/badge/license-Apache--2.0-blue.svg)](LICENSE)
[![DOI](https://zenodo.org/badge/1440173705.svg)](https://doi.org/10.5281/zenodo.23818892)

**Machine-checked Lean 4 proofs of the fifth-order recurrences for OEIS [A048590](https://oeis.org/A048590) and [A048592](https://oeis.org/A048592).**

This repository presents a fully formalized elementary matrix and determinant argument for the **original ceiling-defined sequences**, rather than only for linear candidates. Human formalization author: **Taha Kabiri**. Development and generation/revision of Lean code were assisted by ChatGPT/Codex; see [AUTHORS.md](AUTHORS.md) for transparent attribution.

## Start here: proof and verification

This page is the central index of the research evidence for **both** sequences. The original recurrence conjectures predate this work; Taha Kabiri's contribution is the mathematical proof and its AI-assisted Lean formalization.

1. **Mathematical proof (13-page PDF):** [Two Ceiling Pisot Sequences Satisfying a Fifth-Order Recurrence](paper/Kabiri_A048590_A048592_OEIS_revised.pdf). This contains the conventional written proof, including the fourteen-step matrix induction, and also reports additional mathematical results.
2. **Machine-checked proof (Lean 4):** [Final recurrence theorems](Pisot/OriginalRecurrences.lean) for the original ceiling-defined sequences; see the [proof map](docs/PROOF_DEPENDENCIES.md) and [statement summary](docs/TECHNICAL_VERIFICATION_SUMMARY.md).
3. **How to verify it yourself:** [Build and reproduction instructions](docs/BUILD.md), including the exact Lean/Mathlib versions, with source-integrity information under [provenance](provenance/README.md).
4. **Permanent archive of the Lean formalization:** [Zenodo DOI 10.5281/zenodo.23818892](https://doi.org/10.5281/zenodo.23818892), corresponding to the fixed GitHub [v1.0.0 release](https://github.com/tahahhsr-code/pisot-ceiling-recurrences/releases/tag/v1.0.0).

**Provenance and scope:** The PDF is an **AI-assisted research reference manuscript**, not a human-written submission ready for the *Journal of Integer Sequences*. Its English prose was drafted and revised with ChatGPT/Codex assistance; AI tools also assisted in developing mathematical arguments and computer checks. The [manuscript notes](paper/README.md) explain this provenance. The Lean verification certifies the recurrence theorems and their supporting proof, **not** all additional results in the manuscript. The PDF was added to the `main` branch **after** the fixed v1.0.0 GitHub/Zenodo release; that DOI archives the earlier Lean-source release and **does not include this PDF**.



## The theorem

With indices beginning at zero, the initial pairs are `(8, 9)` and `(9, 10)`. For either sequence,

```text
a(n+2) = ceil(a(n+1)^2 / a(n))
```

where the quotient is computed in the rationals and the ceiling rounds upward. Lean proves positivity of all divisors. Both original sequences satisfy, for **every natural number n ≥ 6**,

```text
a(n) = 2*a(n-1) - a(n-2) + a(n-4) - a(n-5).
```

The final theorem declarations are `Pisot.A048590_fifth_rec` and `Pisot.A048592_fifth_rec` in [`Pisot/OriginalRecurrences.lean`](Pisot/OriginalRecurrences.lean). All sequence-value subtraction in these theorems is performed in the integers. The identification of each original nonlinear sequence with its linear-recurrence candidate is proved for all indices, not assumed.

## Reproduce the proofs

Prerequisites: Git, Python 3.9+, and Lean via [Elan](https://github.com/leanprover/elan). The project pins **Lean 4.19.0** and Mathlib commit `c44e0c8ee63ca166450922a373c7409c5d26b00b` (plus the other locked dependencies). From a fresh checkout:

```bash
python3 scripts/verify_package.py
lake exe cache get
lake build
lake env lean audit/M6FinalAudit.lean
lake env lean audit/ReleaseStatementAudit.lean
```

Or use `bash scripts/reproduce.sh` from a clean checkout or fresh source archive. See [build instructions](docs/BUILD.md) for environmental details. A [source-integrity manifest](provenance/package.sha256) and [module-level proof map](docs/PROOF_DEPENDENCIES.md) are provided.

## Verification scope and trust

All 22 Lean project modules and the original pinned build configuration remain **byte-for-byte identical to the independently tested M6 mathematics**. The historical M6 build and the standalone Mission 2 and 3 acceptance builds completed with exit 0. The final two recurrence theorems and 82 public theorem axiom closures were checked in the acceptance audits; their only axioms are the usual Lean foundations `propext`, `Classical.choice`, and `Quot.sound`. These are **not** claims of independent third-party human peer review.

The source package is a versioned publication of the same mathematical proof sources with approved publication documentation and license. The new public release itself is not claimed to have undergone a separate fresh Lean build unless one is reported for that exact artifact. Run the commands above to independently reproduce the verification.

Formal verification covers the elementary matrix/determinant argument and the two original fifth-order recurrences. **It does not certify spectral analyses, asymptotics or every claim in separate manuscripts.** No journal or OEIS acceptance is claimed.

See the [exact theorem statements and mathematical summary](docs/TECHNICAL_VERIFICATION_SUMMARY.md), [formalization contract](docs/FORMALIZATION_CONTRACT.md), and [verification provenance](provenance/README.md).

## Citation, license and attribution

Please use [`CITATION.cff`](CITATION.cff) to cite version **1.0.0**. Zenodo DOI for GitHub release **v1.0.0**: [**10.5281/zenodo.23818892**](https://doi.org/10.5281/zenodo.23818892). The original Lean source, scripts, and technical documentation are provided under the [Apache License 2.0](LICENSE) to the extent the author holds the necessary rights; the PDF manuscript in [paper/](paper/) is provided as a research reference and **is not licensed under Apache-2.0** (see [manuscript notes](paper/README.md)); see [NOTICE](NOTICE) and [third-party dependency notes](docs/THIRD_PARTY_REVIEW.md). External Lean/Mathlib source and binaries are not bundled. Original OEIS entry and conjecture attribution is distinguished from software/formalization authorship in [AUTHORS.md](AUTHORS.md).
