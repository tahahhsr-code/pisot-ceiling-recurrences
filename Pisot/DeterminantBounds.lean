import Pisot.Invariant14

/-!
# M4: shifted candidate determinants

`D t j` is the manuscript determinant at index `n = j+2`.
Both the determinant and its eventual denominator `u t j` are integer-valued.
The definition uses only additive natural indices.
-/
namespace Pisot

/-- The candidate determinant at manuscript index `j+2`. -/
def D (t : ℤ) (j : ℕ) : ℤ :=
  u t (j + 2) * u t j - (u t (j + 1)) ^ 2

/-- The core second difference needed for the shifted determinant identity. -/
theorem B_second_difference_int (j : ℕ) :
    (B (j + 8) : ℤ) + (B (j + 6) : ℤ) - 2 * (B (j + 7) : ℤ) = B j := by
  have h0 := B_rec_int j
  have h3 : (B (j + 7) : ℤ) = (B (j + 6) : ℤ) + B (j + 3) :=
    B_rec_int (j + 3)
  have h4 : (B (j + 8) : ℤ) = (B (j + 7) : ℤ) + B (j + 4) :=
    B_rec_int (j + 4)
  omega

/-- The determinant identity for every integer shift and manuscript index at least nine. -/
theorem D_shift_identity (t : ℤ) (j : ℕ) :
    D t (j + 7) = W (j + 4) 0 + t * (B j : ℤ) := by
  change ((B (j + 8) : ℤ) + t) * ((B (j + 6) : ℤ) + t) -
      ((B (j + 7) : ℤ) + t) ^ 2 =
    ((B (j + 8) : ℤ) * (B (j + 6) : ℤ) -
      (B (j + 7) : ℤ) * (B (j + 7) : ℤ)) + t * (B j : ℤ)
  linear_combination t * B_second_difference_int j

/-- The first determinant coordinate lies between the signed core bounds. -/
theorem W0_tail_bounds (j : ℕ) :
    -(B (j + 11) : ℤ) ≤ W (j + 15) 0 ∧
      W (j + 15) 0 ≤ (B (j + 11) : ℤ) := by
  have hn : Int.natAbs (W (j + 15) 0) ≤ B (j + 11) :=
    (maxAbs6_coord_le (W (j + 15)) 0).trans (W_invariant j)
  have hc : (Int.natAbs (W (j + 15) 0) : ℤ) ≤ (B (j + 11) : ℤ) := by
    exact_mod_cast hn
  have hp : W (j + 15) 0 ≤ (Int.natAbs (W (j + 15) 0) : ℤ) :=
    Int.le_natAbs
  have hm : -W (j + 15) 0 ≤ (Int.natAbs (W (j + 15) 0) : ℤ) := by
    simpa only [Int.natAbs_neg] using
      (Int.le_natAbs (a := -W (j + 15) 0))
  omega

/-- Strict tail inequalities for both candidate shifts, at manuscript indices at least twenty. -/
theorem D_tail_strict (t : ℤ) (ht : t = 3 ∨ t = 4) (j : ℕ) :
    0 < D t (j + 18) ∧ D t (j + 18) < u t (j + 18) := by
  have hw := W0_tail_bounds j
  have hgNat : 43 * B (j + 11) ≤ 8 * B (j + 17) := B_growth6 (j + 8)
  have hg : 43 * (B (j + 11) : ℤ) ≤ 8 * (B (j + 17) : ℤ) := by
    exact_mod_cast hgNat
  have hp : (0 : ℤ) < B (j + 11) := by
    exact_mod_cast B_pos (j + 11)
  have hd : D t (j + 18) = W (j + 15) 0 + t * (B (j + 11) : ℤ) :=
    D_shift_identity t (j + 11)
  have hu : u t (j + 18) = (B (j + 17) : ℤ) + t :=
    u_succ t (j + 17)
  rcases ht with rfl | rfl <;> constructor <;> omega

/-- The required nonnegative determinant bound for shift three on the whole infinite tail. -/
theorem D3_tail (j : ℕ) :
    0 ≤ D 3 (j + 18) ∧ D 3 (j + 18) < u 3 (j + 18) := by
  have h := D_tail_strict 3 (Or.inl rfl) j
  exact ⟨h.1.le, h.2⟩

/-- The required nonnegative determinant bound for shift four on the whole infinite tail. -/
theorem D4_tail (j : ℕ) :
    0 ≤ D 4 (j + 18) ∧ D 4 (j + 18) < u 4 (j + 18) := by
  have h := D_tail_strict 4 (Or.inr rfl) j
  exact ⟨h.1.le, h.2⟩

/-- All eighteen finite cases for shift three, at manuscript indices two through nineteen. -/
theorem D3_finite :
    ∀ j ∈ Finset.range 18, 0 ≤ D 3 j ∧ D 3 j < u 3 j := by
  intro j hj
  have hjlt : j < 18 := Finset.mem_range.mp hj
  interval_cases j <;> decide

/-- All eighteen finite cases for shift four, at manuscript indices two through nineteen. -/
theorem D4_finite :
    ∀ j ∈ Finset.range 18, 0 ≤ D 4 j ∧ D 4 j < u 4 j := by
  intro j hj
  have hjlt : j < 18 := Finset.mem_range.mp hj
  interval_cases j <;> decide

/-- The equality case for shift three is at manuscript index six. -/
theorem D3_four : D 3 4 = 0 := by decide

/-- The determinant inequalities for shift three at every manuscript index at least two. -/
theorem D3_all (j : ℕ) : 0 ≤ D 3 j ∧ D 3 j < u 3 j := by
  by_cases hj : j < 18
  · exact D3_finite j (Finset.mem_range.mpr hj)
  · obtain ⟨k, rfl⟩ : ∃ k, j = k + 18 := ⟨j - 18, by omega⟩
    exact D3_tail k

/-- The determinant inequalities for shift four at every manuscript index at least two. -/
theorem D4_all (j : ℕ) : 0 ≤ D 4 j ∧ D 4 j < u 4 j := by
  by_cases hj : j < 18
  · exact D4_finite j (Finset.mem_range.mpr hj)
  · obtain ⟨k, rfl⟩ : ∃ k, j = k + 18 := ⟨j - 18, by omega⟩
    exact D4_tail k

end Pisot
