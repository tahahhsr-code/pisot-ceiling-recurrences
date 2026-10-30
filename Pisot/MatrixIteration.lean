import Pisot.MatrixNorm

/-!
# M2B-2B: iteration of the determinant transition

`W k` is manuscript `W_(k+5)`. Iteration starts at every natural `k`,
including zero, and uses only the already verified one-step transition.
-/
namespace Pisot

open Matrix

/-- Iterate the determinant transition through any number of steps. -/
theorem W_iterate (k r : ℕ) : W (k + r) = (M ^ r) *ᵥ W k := by
  induction r with
  | zero => simp only [Nat.add_zero, pow_zero, Matrix.one_mulVec]
  | succ r ih =>
    calc
      W (k + (r + 1)) = M *ᵥ W (k + r) := by
        rw [← Nat.add_assoc, W_step]
      _ = M *ᵥ ((M ^ r) *ᵥ W k) := by rw [ih]
      _ = (M * M ^ r) *ᵥ W k := Matrix.mulVec_mulVec (W k) M (M ^ r)
      _ = (M ^ (r + 1)) *ᵥ W k := by rw [pow_succ']

/-- The fourteen-step transition holds at every natural starting index. -/
theorem W_step14 (k : ℕ) : W (k + 14) = (M ^ 14) *ᵥ W k :=
  W_iterate k 14

/-- The universal fourteen-step bound, including manuscript index five. -/
theorem W_maxAbs6_step14 (k : ℕ) :
    maxAbs6 (W (k + 14)) ≤ 61 * maxAbs6 (W k) := by
  rw [W_step14]
  exact M_pow14_maxAbs6_le (W k)

end Pisot
