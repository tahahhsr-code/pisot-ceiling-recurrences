# Mathematical manuscript — provenance and use

**Title:** Two Ceiling Pisot Sequences Satisfying a Fifth-Order Recurrence  
**Author:** Taha Kabiri  
**File:** [Kabiri_A048590_A048592_OEIS_revised.pdf](Kabiri_A048590_A048592_OEIS_revised.pdf)  
**Length:** 13 pages  
**Scope:** Original ceiling-defined OEIS sequences [A048590](https://oeis.org/A048590) and [A048592](https://oeis.org/A048592).

This document presents the ordinary mathematical proof of the fifth-order recurrence for both sequences, alongside additional statements about the sequences. The central recurrence results and necessary supporting arguments have also been formalized in Lean 4. The [Lean source](../Pisot/OriginalRecurrences.lean), [verification instructions](../docs/BUILD.md), and [versioned archive](https://doi.org/10.5281/zenodo.23818892) can be accessed from the [repository overview](../README.md).

## Authorship and AI assistance

This PDF is a **research reference edition, not a human-written journal submission**. Its English exposition and organization were drafted and revised with OpenAI ChatGPT/Codex assistance. These tools also assisted in exploring mathematical reductions, the determinant and fourteen-step induction method, the spectral analysis, computing programs, and verification workflows. Taha Kabiri is identified as the human author and researcher; AI tools are not human coauthors or independent human reviewers.

The Lean 4 artifact verifies the two original recurrence theorems and their required supporting mathematical arguments. It does **not** establish machine-checked verification of every further claim in the PDF (for example, the asymptotic analysis). No independent human peer review or journal acceptance is claimed.

## Versioning and rights

This PDF was added to the GitHub `main` branch **after** the published `v1.0.0` release. It is **not included** in the source archive assigned DOI [10.5281/zenodo.23818892](https://doi.org/10.5281/zenodo.23818892), which belongs to the Lean-source release.

**PDF copyright:** © 2026 Taha Kabiri. All rights reserved unless separately authorized. The repository's Apache-2.0 license applies to the original software and technical documentation, **not to this manuscript PDF**. This file is publicly viewable for research reference; publication here is not a grant of a separate permissive license for the manuscript.
