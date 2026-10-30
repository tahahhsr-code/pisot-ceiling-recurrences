import Pisot.MatrixPowers

/-!
# M2B-2A1: maximum absolute coordinate and exact row sums

The determinant coordinates retain the order `(01,02,03,12,13,23)`.
The finite row calculations use the already verified `M_pow14` equality.
-/
namespace Pisot

open Matrix

/-- Maximum of the six absolute integer coordinates, valued in the naturals. -/
def maxAbs6 (z : Fin 6 → ℤ) : ℕ :=
  Finset.univ.sup (fun i : Fin 6 => Int.natAbs (z i))

/-- All six absolute row sums of the fourteenth determinant transition power. -/
theorem M_pow14_rowSums :
    (fun i : Fin 6 => ∑ j : Fin 6, Int.natAbs ((M ^ 14) i j)) =
      ![55, 61, 59, 37, 52, 32] := by
  rw [M_pow14]
  decide

/-- Every absolute row sum is at most 61. -/
theorem M_pow14_rowSum_le (i : Fin 6) :
    (∑ j : Fin 6, Int.natAbs ((M ^ 14) i j)) ≤ 61 := by
  have hi := congrFun M_pow14_rowSums i
  change (∑ j : Fin 6, Int.natAbs ((M ^ 14) i j)) = ![55, 61, 59, 37, 52, 32] i at hi
  rw [hi]
  fin_cases i <;> decide

/-! ## M2B-2A2: the universal operator bound -/

/-- Each absolute coordinate is bounded by the maximum of all six. -/
theorem maxAbs6_coord_le (z : Fin 6 → ℤ) (j : Fin 6) :
    Int.natAbs (z j) ≤ maxAbs6 z := by
  exact Finset.le_sup (f := fun i : Fin 6 => Int.natAbs (z i)) (Finset.mem_univ j)

/-- The finite-sum triangle inequality bounds each matrix-vector coordinate. -/
theorem row_mulVec_natAbs_le (T : Matrix (Fin 6) (Fin 6) ℤ)
    (z : Fin 6 → ℤ) (i : Fin 6) :
    Int.natAbs ((T *ᵥ z) i) ≤
      (∑ j : Fin 6, Int.natAbs (T i j)) * maxAbs6 z := by
  change Int.natAbs (∑ j : Fin 6, T i j * z j) ≤ _
  calc
    Int.natAbs (∑ j : Fin 6, T i j * z j)
        ≤ ∑ j : Fin 6, Int.natAbs (T i j * z j) :=
      nat_abs_sum_le Finset.univ (fun j => T i j * z j)
    _ = ∑ j : Fin 6, Int.natAbs (T i j) * Int.natAbs (z j) := by
      simp only [Int.natAbs_mul]
    _ ≤ ∑ j : Fin 6, Int.natAbs (T i j) * maxAbs6 z :=
      Finset.sum_le_sum fun j _ =>
        Nat.mul_le_mul_left _ (maxAbs6_coord_le z j)
    _ = (∑ j : Fin 6, Int.natAbs (T i j)) * maxAbs6 z := by
      rw [Finset.sum_mul]

/-- The fourteenth determinant transition power has operator bound 61. -/
theorem M_pow14_maxAbs6_le (z : Fin 6 → ℤ) :
    maxAbs6 ((M ^ 14) *ᵥ z) ≤ 61 * maxAbs6 z := by
  change Finset.univ.sup (fun i : Fin 6 => Int.natAbs (((M ^ 14) *ᵥ z) i)) ≤
    61 * maxAbs6 z
  apply Finset.sup_le
  intro i _
  calc
    Int.natAbs (((M ^ 14) *ᵥ z) i)
        ≤ (∑ j : Fin 6, Int.natAbs ((M ^ 14) i j)) * maxAbs6 z :=
      row_mulVec_natAbs_le (M ^ 14) z i
    _ ≤ 61 * maxAbs6 z :=
      Nat.mul_le_mul_right (maxAbs6 z) (M_pow14_rowSum_le i)

end Pisot
