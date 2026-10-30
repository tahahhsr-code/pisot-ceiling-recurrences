# Technical verification summary

Prepared 2026-10-30 for researchers evaluating the software. This is an
open-source formal proof package, not an OEIS submission or human peer-review report.

## Object and exact statements

The functions below occur in namespace `Pisot` in `Pisot/Core.lean`:

```lean
def ceilingSequence (a b : ℕ) : ℕ → ℕ
  | 0 => a
  | 1 => b
  | n + 2 => ⌈(ceilingSequence a b (n + 1) : ℚ) ^ 2 /
      (ceilingSequence a b n : ℚ)⌉₊

def A048590 : ℕ → ℕ := ceilingSequence 8 9
def A048592 : ℕ → ℕ := ceilingSequence 9 10
```

Indices start at 0 and 1. The update uses the natural ceiling of an explicitly
rational quotient with squared numerator. It is neither natural-number division
nor nearest-integer rounding. For the two specified positive seed pairs,
`A048590_pos` and `A048592_pos` prove positivity at every index, so actual
divisors are positive. `ceilingSequence_rec_int` proves agreement with integer
ceiling on the nonnegative quotient.

The exact theorem signatures from `Pisot/OriginalRecurrences.lean`, inside
namespace `Pisot`, are:

```lean
theorem A048590_fifth_rec (n : ℕ) (hn : 6 ≤ n) :
    (A048590 n : ℤ) =
      2 * (A048590 (n - 1) : ℤ) -
      (A048590 (n - 2) : ℤ) +
      (A048590 (n - 4) : ℤ) -
      (A048590 (n - 5) : ℤ)

theorem A048592_fifth_rec (n : ℕ) (hn : 6 ≤ n) :
    (A048592 n : ℤ) =
      2 * (A048592 (n - 1) : ℤ) -
      (A048592 (n - 2) : ℤ) +
      (A048592 (n - 4) : ℤ) -
      (A048592 (n - 5) : ℤ)
```

The only explicit hypothesis is `6 ≤ n`. Every sequence value is cast to `ℤ`
before subtraction. Natural subtraction occurs only in the indices, where the
lower bound makes each predecessor meaningful. The result includes n = 6 and
does not assert the recurrence at n = 5. There is no finite upper bound and
no assumed identification with a linear sequence.

## Mathematical dependency chain

1. Define `B(0..3)=(6,8,11,15)` and `B(k+4)=B(k+3)+B(k)`.
   Define integer candidates `u(t,0)=t+5`, `u(t,k+1)=B(k)+t`, with t=3,4.
   Their fifth-order recurrences are elementary consequences of the core recurrence.
2. Define the four-dimensional integer state `x(k)` and six oriented minors
   `W(k)=wedge(x(k+1),x(k))`, in order 01,02,03,12,13,23. Prove the
   universal transitions `x_step`, `wedge_A`, and `W_step`.
3. Prove exact matrix powers `A_pow6`, `A_pow14`, `M_pow14`. The absolute row
   sums of `M^14` are 55,61,59,37,52,32. Prove the operator bound for every
   integer six-vector and iterate the transition to obtain determinant growth ≤61
   over fourteen steps.
4. Prove `43*B(k+3) ≤ 8*B(k+9)` and `141*B(k+3) ≤ 2*B(k+17)` universally.
   Fourteen proved finite base rows and strong induction establish
   `maxAbs6 (W (j+15)) ≤ B (j+11)` for every natural j. The induction step uses
   `2*61 ≤ 141`, not numerical sampling of the infinite tail.
5. Define `D t j = u t (j+2)*u t j - (u t (j+1))^2` in integers.
   Prove `D t (j+7)=W(j+4) 0+t*B(j)`, tail bounds, and 18 finite cases
   for each shift. The universal conclusions are `0 ≤ D t j < u t j` for
   t=3 and t=4. `D3_four` proves `D 3 4 = 0`, corresponding to sequence index 6.
6. Prove, for integers v,q,d with d>0,
   `v=ceil(q/d) ↔ 0≤v*d-q ∧ v*d-q<d` using rational division.
   Apply the determinant bounds and positivity to obtain the candidates' exact
   ceiling updates. Strong-induction uniqueness gives
   `(A048590 n : ℤ)=candidate590 n` and `(A048592 n : ℤ)=candidate592 n`
   at every natural n. Transfer the already proved candidate recurrences.

See [PROOF_DEPENDENCIES.md](PROOF_DEPENDENCIES.md) for module-level imports.
Finite tables are proved inside Lean with ordinary kernel-checked `decide`;
no Python numerical result is imported as a mathematical premise.

## Verification evidence and provenance

Mission 2 rebuilt the original standalone source ZIP successfully with Lean
4.19.0: 22 project modules freshly compiled, 82 theorem axiom closures checked,
and 16 additional explicit statement checks accepted. Both final recurrence
constants were accepted with their literal types. The recovered Mission 2
acceptance bundle and its source ZIP match their saved SHA-256 identities.

The 27 preserved M6 files are byte-identical in this publication. The Mission 3
prepublication 55-file snapshot was freshly rebuilt and audited successfully.
This public package changes only non-mathematical publication documentation,
which is hash-checked separately; a new build is needed to certify its exact bytes. Standard Mathlib dependency caches are permitted; project
build artifacts are never copied into a clean release build.

The M6-tested mathematical commit is
`a37dfa299f63b8cbd753a9dc787a1cf61b02b50c`; final M6 documentation commit is
`6ea11cf7905a4759dc34817109daf1a6fce07075`. No private Git history is included.

## Foundations and trust boundary

The recorded M6 axiom closures for both final theorems are exactly
`[propext, Classical.choice, Quot.sound]`: propositional extensionality,
classical choice, and quotient soundness. These are standard Lean foundations;
the project is not described as axiom-free. Across the 82 public theorems,
66 use that triple, 4 use propext and Quot.sound, 5 use propext, and 7 use none.
Private helpers are covered transitively by their public users' axiom closures.

The project source scan rejects placeholders, custom axioms, unsafe/native
evaluation, kernel option overrides, custom elaboration, ambient hypotheses,
opaque additions and notation overrides. Such a scan is a secondary check;
it is not a substitute for Lean elaboration, the kernel, or a semantic review
of the theorem statements.

Trust includes the installed Lean 4.19.0 implementation and runtime, the
mathematical foundations above, correctness/integrity of imported compiled
dependencies, and the execution platform. Standard Mathlib caches were used
in M6, so M6 did not rebuild every external dependency from source. Hashes
establish byte identity relative to recorded evidence, not an independent
signature or proof of the truth of the evidence. The record and this package
do not constitute an independently implemented kernel check or third-party
human peer review. AI assistance is disclosed in [AUTHORS.md](../AUTHORS.md).

## Scope and explicit nonclaims

The formalization covers the elementary matrix argument, universal candidate
determinant bounds, identification with both original ceiling sequences, and
both n≥6 recurrences. The optional unique-zero iff strengthening and a separately
named all-index strict-positivity theorem for shift four were not added.

Spectral/root-location arguments, asymptotic statements or numerical limit
formulas in separate manuscripts are outside this package's certified scope.
No manuscript is bundled or certified in its entirety. This summary does not
re-evaluate those additional results. It makes no novelty, priority, journal
acceptance, or OEIS acceptance claim. Successful clean release tests establish reproducibility under the stated assumptions,
not independent peer review.
