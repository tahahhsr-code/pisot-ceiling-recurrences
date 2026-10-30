# Stage 2 — Formalization contract (Lean 4 + Mathlib)

**Status:** Specification only. No Lean theorem has yet been compiled or certified.

**Authority:** `sources/proofs/A048590-proof (1).md` (matrix argument); cross-check against `sources/verification/verify_matrix.py` and `sources/verification/independent_A048590_check.py`. Treat the spectral manuscript as reference only, not the current target.

## 1. Exact mathematical target

For each initial pair `(8,9)` and `(9,10)`, consider its *unique positive-integer* sequence `P : ℕ → ℕ` with these first two terms and

`P(n) = ceil(P(n-1)^2 / P(n-2))`, for every `n ≥ 2`.

Prove that in both cases, for **all** `n ≥ 6`, in the integers,

`P(n) = 2*P(n-1) - P(n-2) + P(n-4) - P(n-5)`.

Make the initial indices and ceiling semantics explicit; use `ℤ` or `ℚ` casts instead of silently truncated `Nat.sub`. For `n = 5`, the linear recurrence is *not* asserted. Demonstrate precise connection between the function formalized in Lean and these OEIS starting conditions.

Desirable strengthening: for the `(8,9)` sequence, `P(n)*P(n-2)-P(n-1)^2=0` exactly at `n=6`; for the `(9,10)` sequence it is always positive for `n≥2`.

## 2. Preferred candidate and avoidance of b₀ ambiguity

Use a fourth-order core sequence with non-negative indexing, e.g.

- `B(0)=6`, `B(1)=8`, `B(2)=11`, `B(3)=15`;
- `B(k+4)=B(k+3)+B(k)` for `k≥0`.

This is `B(k)=b_(k+1)` relative to the source manuscript, **not** the manuscript's `c(0)-3`.

Define candidate `u_t(0)=t+5`, `u_t(n+1)=B(n)+t` for `t=3,4`. The beginning is

- `u_3 : 8,9,11,14,18,24,32,...`
- `u_4 : 9,10,12,15,19,25,33,...`.

Prove, for all `n≥2`, positivity and the exact determinant inequality

`0 ≤ D_t(n) = u_t(n)*u_t(n-2) - u_t(n-1)^2 < u_t(n-2)`.

This is over `ℤ` with casted `u_t`. Then formalize the equivalence of that inequality and the ceiling update, and uniqueness from the first two terms.

## 3. Matrix lemmas corresponding to source sections

Build `A : Matrix (Fin 4) (Fin 4) ℤ` and `M : Matrix (Fin 6) (Fin 6) ℤ` as explicitly printed in section 2. Define the four-coordinate state `x_n` and six-coordinate pairwise determinants `W_n`, ordered `(01,02,03,12,13,23)`.

Prove (do not merely assume or numerically sample):

1. `x_(n+1)=A*x_n` and `W_(n+1)=M*W_n` for applicable `n`.
2. Exact matrix power equalities for `A^6`, `A^14`, and `M^14`. Source has the complete matrices.
3. `‖W_(n+14)‖∞ ≤ 61‖W_n‖∞` as an elementary max-coordinate bound (norm or explicit sup over `Fin 6`).
4. `b_(m+14) ≥ (141/2)b_m` and `b_(m+6) ≥ (43/8)b_m`, with valid indices and rational/integer-scaled inequalities. Avoid division in `ℕ`; prefer `2*b_(m+14) ≥ 141*b_m`, `8*b_(m+6) ≥ 43*b_m`.
5. All fourteen finite induction bases `n=20,..,33` for `‖W_n‖∞≤b_(n-8)`; prove the infinite result by fourteen residue-class inductions.
6. For `n≥9`, prove `D_t(n)=W_n(01)+t*b_(n-8)`.
7. For `n≥20`, prove `0 < D_t(n) < u_t(n-2)`; for `2≤n≤19`, exact finite checks.
8. Prove the final original-sequence recurrence for **both** initial pairs and, ideally, the unique equality case.

The source gives `W_5=(6,3,6,-1,2,2)`, `‖M^14‖∞=61`, the fourteen bases, and `D_3(6)=0`; cross-check these against the independent verification scripts.

## 4. Requirements for a credible formal proof

- Create an actual Lean 4 / Mathlib project **under `lean/`**, and commit `lean-toolchain`, `lakefile.toml` or `lakefile.lean`, `lake-manifest.json`, full Lean source, and build instructions.
- `lake build` must complete successfully in the repository's own project directory. Record the exact toolchain and dependency commit IDs.
- No `sorry`, `admit`, `sorryAx`, `unsafe` axioms, `axiom` declarations, fake hypotheses that encode the result, or replacing general theorems by finitely tested cases.
- Query `#print axioms` of every final theorem. Report all axioms honestly; explicitly verify there is no `sorryAx` or new/custom axiom.
- Review the statements of the **final theorems** independently of their proof terms: seed values, all quantifiers, ceiling/rounding convention, index bounds, and casts must match the source claim.
- Finite Python tests are not a substitute for Lean's proofs; `#eval` or `example : True` cannot stand in for the required theorem.
- Only report "formalized" once *every* target theorem typechecks with no assumptions beyond standard Lean/Mathlib foundations.

## 5. Scope guardrails

- Do not edit the historical source files under `sources/`.
- Keep all modifications in working branch `formalization/lean4-matrix`, leaving `main` and `archive/v0.1-research-archive` intact.
- If blocked, preserve compileable lemmas, record exact open goals, and mark the state explicitly `PARTIAL`. Do not claim full completion.
- Do not spend time on the spectral proof, journal formatting, manuscript prose or publication tasks.
