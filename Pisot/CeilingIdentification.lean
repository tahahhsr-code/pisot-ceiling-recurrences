import Pisot.DeterminantBounds

/-!
# M5A: identification with the original ceiling sequences

The determinant bounds imply the integer ceiling of a rational quotient.
Uniqueness of the second-order update then identifies the existing natural-valued
OEIS sequences with the integer-valued candidates at every natural index.
The original sequences and their natural ceiling definitions are unchanged.
-/
namespace Pisot

/-- Exact determinant characterization of a rational ceiling with a positive divisor. -/
theorem eq_ceil_div_iff (v q d : ℤ) (hd : 0 < d) :
    v = ⌈(q : ℚ) / (d : ℚ)⌉ ↔ 0 ≤ v * d - q ∧ v * d - q < d := by
  have hdq : (0 : ℚ) < (d : ℚ) := by exact_mod_cast hd
  rw [eq_comm, Int.ceil_eq_iff, lt_div_iff₀ hdq, div_le_iff₀ hdq]
  constructor
  · rintro ⟨hlo, hhi⟩
    have hloInt : (v - 1) * d < q := by exact_mod_cast hlo
    have hhiInt : q ≤ v * d := by exact_mod_cast hhi
    constructor <;> nlinarith
  · rintro ⟨hlo, hhi⟩
    have hloRat : (0 : ℚ) ≤ (v : ℚ) * (d : ℚ) - (q : ℚ) := by
      exact_mod_cast hlo
    have hhiRat : (v : ℚ) * (d : ℚ) - (q : ℚ) < (d : ℚ) := by
      exact_mod_cast hhi
    constructor <;> nlinarith

/-- The shift-three candidate satisfies the exact ceiling update at every step. -/
theorem u3_ceil_rec (j : ℕ) :
    u 3 (j + 2) = ⌈(u 3 (j + 1) : ℚ) ^ 2 / (u 3 j : ℚ)⌉ := by
  have h := (eq_ceil_div_iff (u 3 (j + 2)) ((u 3 (j + 1)) ^ 2) (u 3 j)
    (u_pos (by norm_num) j)).mpr (D3_all j)
  simpa only [Int.cast_pow] using h

/-- The shift-four candidate satisfies the exact ceiling update at every step. -/
theorem u4_ceil_rec (j : ℕ) :
    u 4 (j + 2) = ⌈(u 4 (j + 1) : ℚ) ^ 2 / (u 4 j : ℚ)⌉ := by
  have h := (eq_ceil_div_iff (u 4 (j + 2)) ((u 4 (j + 1)) ^ 2) (u 4 j)
    (u_pos (by norm_num) j)).mpr (D4_all j)
  simpa only [Int.cast_pow] using h

/-- Two sequences with the same initial pair and ceiling update agree everywhere. -/
theorem int_ceiling_sequence_unique (f g : ℕ → ℤ)
    (h0 : f 0 = g 0) (h1 : f 1 = g 1)
    (hf : ∀ j, f (j + 2) = ⌈(f (j + 1) : ℚ) ^ 2 / (f j : ℚ)⌉)
    (hg : ∀ j, g (j + 2) = ⌈(g (j + 1) : ℚ) ^ 2 / (g j : ℚ)⌉)
    (n : ℕ) : f n = g n := by
  induction n using Nat.strong_induction_on with
  | h n ih =>
    by_cases hn : n < 2
    · interval_cases n
      · exact h0
      · exact h1
    · obtain ⟨k, rfl⟩ : ∃ k, n = k + 2 := ⟨n - 2, by omega⟩
      rw [hf k, hg k, ih (k + 1) (by omega), ih k (by omega)]

/-- The original sequence starting with eight and nine equals its candidate at every index. -/
theorem A048590_eq_candidate (n : ℕ) :
    (A048590 n : ℤ) = candidate590 n := by
  refine int_ceiling_sequence_unique
    (fun k => (A048590 k : ℤ)) candidate590 rfl rfl ?_ ?_ n
  · intro j
    simpa only [A048590, Int.cast_natCast] using ceilingSequence_rec_int 8 9 j
  · intro j
    exact u3_ceil_rec j

/-- The original sequence starting with nine and ten equals its candidate at every index. -/
theorem A048592_eq_candidate (n : ℕ) :
    (A048592 n : ℤ) = candidate592 n := by
  refine int_ceiling_sequence_unique
    (fun k => (A048592 k : ℤ)) candidate592 rfl rfl ?_ ?_ n
  · intro j
    simpa only [A048592, Int.cast_natCast] using ceilingSequence_rec_int 9 10 j
  · intro j
    exact u4_ceil_rec j

end Pisot
