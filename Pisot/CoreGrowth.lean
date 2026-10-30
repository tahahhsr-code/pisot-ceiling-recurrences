import Pisot.MatrixPowers

/-!
# M3A-1: state iteration and exact core identities

The first coordinate of `x k` is `(B (k+3) : ℤ)`.
All statements use additive natural indices, including zero.
-/
namespace Pisot

open Matrix

/-- Iterate the verified state transition through any number of steps. -/
theorem x_iterate (k r : ℕ) : x (k + r) = (A ^ r) *ᵥ x k := by
  induction r with
  | zero => simp only [Nat.add_zero, pow_zero, Matrix.one_mulVec]
  | succ r ih =>
    calc
      x (k + (r + 1)) = A *ᵥ x (k + r) := by
        rw [← Nat.add_assoc, x_step]
      _ = A *ᵥ ((A ^ r) *ᵥ x k) := by rw [ih]
      _ = (A * A ^ r) *ᵥ x k := Matrix.mulVec_mulVec (x k) A (A ^ r)
      _ = (A ^ (r + 1)) *ᵥ x k := by rw [pow_succ']

/-- Exact six-step core identity from the first row of `A_pow6`. -/
theorem B_add9 (k : ℕ) :
    B (k + 9) = 4 * B (k + 3) + B (k + 2) + 2 * B (k + 1) + 3 * B k := by
  have h := congrFun (x_iterate k 6) (0 : Fin 4)
  rw [A_pow6] at h
  simp only [Matrix.mulVec, dotProduct, Fin.sum_univ_succ] at h
  change (B (k + 9) : ℤ) =
    4 * (B (k + 3) : ℤ) + (1 * (B (k + 2) : ℤ) +
      (2 * (B (k + 1) : ℤ) + (3 * (B k : ℤ) + 0))) at h
  have hi : (B (k + 9) : ℤ) =
      4 * (B (k + 3) : ℤ) + (B (k + 2) : ℤ) +
        2 * (B (k + 1) : ℤ) + 3 * (B k : ℤ) := by
    simpa only [one_mul, add_zero, add_assoc] using h
  exact_mod_cast hi

/-- Exact fourteen-step core identity from the first row of `A_pow14`. -/
theorem B_add17 (k : ℕ) :
    B (k + 17) = 50 * B (k + 3) + 19 * B (k + 2) +
      26 * B (k + 1) + 36 * B k := by
  have h := congrFun (x_iterate k 14) (0 : Fin 4)
  rw [A_pow14] at h
  simp only [Matrix.mulVec, dotProduct, Fin.sum_univ_succ] at h
  change (B (k + 17) : ℤ) =
    50 * (B (k + 3) : ℤ) + (19 * (B (k + 2) : ℤ) +
      (26 * (B (k + 1) : ℤ) + (36 * (B k : ℤ) + 0))) at h
  have hi : (B (k + 17) : ℤ) =
      50 * (B (k + 3) : ℤ) + 19 * (B (k + 2) : ℤ) +
        26 * (B (k + 1) : ℤ) + 36 * (B k : ℤ) := by
    simpa only [add_zero, add_assoc] using h
  exact_mod_cast hi

/-- Universal six-step growth bound from the exact identity and adjacent ratios. -/
theorem B_growth6 (k : ℕ) :
    43 * B (k + 3) ≤ 8 * B (k + 9) := by
  have h6 := B_add9 k
  have h0 := B_ratio k
  have h1 : B (k + 2) ≤ 2 * B (k + 1) := B_ratio (k + 1)
  have h2 : B (k + 3) ≤ 2 * B (k + 2) := B_ratio (k + 2)
  omega

/-- Universal fourteen-step growth bound from the exact identity and adjacent ratios. -/
theorem B_growth14 (k : ℕ) :
    141 * B (k + 3) ≤ 2 * B (k + 17) := by
  have h14 := B_add17 k
  have h0 := B_ratio k
  have h1 : B (k + 2) ≤ 2 * B (k + 1) := B_ratio (k + 1)
  have h2 : B (k + 3) ≤ 2 * B (k + 2) := B_ratio (k + 2)
  omega

end Pisot
