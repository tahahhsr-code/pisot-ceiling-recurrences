import Pisot.Core

/-!
# M2A: integer states and determinant transitions

`x k` is manuscript `x_(k+4)` and `W k` is manuscript `W_(k+5)`.
The six coordinates are ordered `(01,02,03,12,13,23)` throughout.
All entries and determinants lie in `ℤ`; no backward extension of `B` is used.
-/
namespace Pisot

open Matrix

/-- The four-dimensional transition matrix from the manuscript. -/
def A : Matrix (Fin 4) (Fin 4) ℤ :=
  !![1, 0, 0, 1;
     1, 0, 0, 0;
     0, 1, 0, 0;
     0, 0, 1, 0]

/-- The state at manuscript index `k+4`. -/
def x (k : ℕ) : Fin 4 → ℤ :=
  ![(B (k + 3) : ℤ), (B (k + 2) : ℤ), (B (k + 1) : ℤ), (B k : ℤ)]

/-- An oriented two-by-two minor of the two state vectors. -/
def wedgeCoord (v w : Fin 4 → ℤ) (i j : Fin 4) : ℤ :=
  v i * w j - v j * w i

/-- The six minors in the fixed order `(01,02,03,12,13,23)`. -/
def wedge (v w : Fin 4 → ℤ) : Fin 6 → ℤ :=
  ![wedgeCoord v w 0 1, wedgeCoord v w 0 2, wedgeCoord v w 0 3,
    wedgeCoord v w 1 2, wedgeCoord v w 1 3, wedgeCoord v w 2 3]

/-- This vector is manuscript `W_(k+5)`, with the later state first. -/
def W (k : ℕ) : Fin 6 → ℤ := wedge (x (k + 1)) (x k)

/-- The determinant transition matrix, in the same coordinate order. -/
def M : Matrix (Fin 6) (Fin 6) ℤ :=
  !![0, 0, -1, 0, 0, 0;
     1, 0, 0, 0, -1, 0;
     0, 1, 0, 0, 0, -1;
     1, 0, 0, 0, 0, 0;
     0, 1, 0, 0, 0, 0;
     0, 0, 0, 1, 0, 0]

theorem x_zero : x 0 = ![15, 11, 8, 6] := by
  ext i
  fin_cases i <;> norm_num [x, B]

theorem x_one : x 1 = ![21, 15, 11, 8] := by
  ext i
  fin_cases i <;> norm_num [x, B]

theorem W_zero : W 0 = ![6, 3, 6, -1, 2, 2] := by
  rw [W, x_zero, x_one]
  rfl

/-- Coordinate form of the four-dimensional matrix action. -/
theorem A_mulVec (v : Fin 4 → ℤ) : A *ᵥ v = ![v 0 + v 3, v 0, v 1, v 2] := by
  ext i
  fin_cases i <;>
    simp only [Matrix.mulVec, dotProduct, Fin.sum_univ_succ]
  · change 1 * v 0 + (0 * v 1 + (0 * v 2 + (1 * v 3 + 0))) = v 0 + v 3
    ring
  · change 1 * v 0 + (0 * v 1 + (0 * v 2 + (0 * v 3 + 0))) = v 0
    ring
  · change 0 * v 0 + (1 * v 1 + (0 * v 2 + (0 * v 3 + 0))) = v 1
    ring
  · change 0 * v 0 + (0 * v 1 + (1 * v 2 + (0 * v 3 + 0))) = v 2
    ring

/-- The state transition holds for every natural index, including zero. -/
theorem x_step (k : ℕ) : x (k + 1) = A *ᵥ x k := by
  rw [A_mulVec]
  ext i
  fin_cases i
  · change (B (k + 4) : ℤ) = (B (k + 3) : ℤ) + B k
    exact B_rec_int k
  · rfl
  · rfl
  · rfl

/-- Coordinate form of the determinant matrix in the order `(01,02,03,12,13,23)`. -/
theorem M_mulVec (z : Fin 6 → ℤ) :
    M *ᵥ z = ![-z 2, z 0 - z 4, z 1 - z 5, z 0, z 1, z 3] := by
  ext i
  fin_cases i <;>
    simp only [Matrix.mulVec, dotProduct, Fin.sum_univ_succ]
  · change 0 * z 0 + (0 * z 1 + (-1 * z 2 + (0 * z 3 +
      (0 * z 4 + (0 * z 5 + 0))))) = -z 2
    ring
  · change 1 * z 0 + (0 * z 1 + (0 * z 2 + (0 * z 3 +
      (-1 * z 4 + (0 * z 5 + 0))))) = z 0 - z 4
    ring
  · change 0 * z 0 + (1 * z 1 + (0 * z 2 + (0 * z 3 +
      (0 * z 4 + (-1 * z 5 + 0))))) = z 1 - z 5
    ring
  · change 1 * z 0 + (0 * z 1 + (0 * z 2 + (0 * z 3 +
      (0 * z 4 + (0 * z 5 + 0))))) = z 0
    ring
  · change 0 * z 0 + (1 * z 1 + (0 * z 2 + (0 * z 3 +
      (0 * z 4 + (0 * z 5 + 0))))) = z 1
    ring
  · change 0 * z 0 + (0 * z 1 + (0 * z 2 + (1 * z 3 +
      (0 * z 4 + (0 * z 5 + 0))))) = z 3
    ring

/-- Applying `A` to any two integer vectors acts on their six minors by `M`. -/
theorem wedge_A (v w : Fin 4 → ℤ) :
    wedge (A *ᵥ v) (A *ᵥ w) = M *ᵥ wedge v w := by
  rw [A_mulVec, A_mulVec, M_mulVec]
  ext i
  fin_cases i
  · change (v 0 + v 3) * w 0 - v 0 * (w 0 + w 3) =
      -(v 0 * w 3 - v 3 * w 0)
    ring
  · change (v 0 + v 3) * w 1 - v 1 * (w 0 + w 3) =
      (v 0 * w 1 - v 1 * w 0) - (v 1 * w 3 - v 3 * w 1)
    ring
  · change (v 0 + v 3) * w 2 - v 2 * (w 0 + w 3) =
      (v 0 * w 2 - v 2 * w 0) - (v 2 * w 3 - v 3 * w 2)
    ring
  · rfl
  · rfl
  · rfl

/-- The determinant transition holds for every natural index, including zero. -/
theorem W_step (k : ℕ) : W (k + 1) = M *ᵥ W k := by
  calc
    W (k + 1) = wedge (A *ᵥ x (k + 1)) (A *ᵥ x k) := by
      rw [W, x_step (k + 1), x_step k]
    _ = M *ᵥ W k := wedge_A (x (k + 1)) (x k)

end Pisot
