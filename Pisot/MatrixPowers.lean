import Pisot.MatrixStep

/-!
# M2B-1: exact integer matrix powers

The three public equalities are the complete matrices from manuscript
section 3. Smaller exact products and squaring keep the finite calculations
small. Each `decide` proof is checked by Lean's kernel.
-/
namespace Pisot

open Matrix

private theorem A_pow2 : A ^ 2 =
    !![1, 0, 1, 1;
       1, 0, 0, 1;
       1, 0, 0, 0;
       0, 1, 0, 0] := by
  decide

private theorem A_pow4 : A ^ 4 =
    !![2, 1, 1, 1;
       1, 1, 1, 1;
       1, 0, 1, 1;
       1, 0, 0, 1] := by
  calc
    A ^ 4 = (A ^ 2) ^ 2 := pow_mul A 2 2
    _ = _ := by rw [A_pow2]; decide

/-- The exact sixth power of the state matrix over the integers. -/
theorem A_pow6 : A ^ 6 =
    !![4, 1, 2, 3;
       3, 1, 1, 2;
       2, 1, 1, 1;
       1, 1, 1, 1] := by
  calc
    A ^ 6 = A ^ 4 * A ^ 2 := pow_add A 4 2
    _ = _ := by rw [A_pow4, A_pow2]; decide

private theorem A_pow7 : A ^ 7 =
    !![5, 2, 3, 4;
       4, 1, 2, 3;
       3, 1, 1, 2;
       2, 1, 1, 1] := by
  calc
    A ^ 7 = A ^ 6 * A := pow_succ A 6
    _ = _ := by rw [A_pow6]; decide

/-- The exact fourteenth power of the state matrix over the integers. -/
theorem A_pow14 : A ^ 14 =
    !![50, 19, 26, 36;
       36, 14, 19, 26;
       26, 10, 14, 19;
       19, 7, 10, 14] := by
  calc
    A ^ 14 = (A ^ 7) ^ 2 := pow_mul A 7 2
    _ = _ := by rw [A_pow7]; decide

private theorem M_pow2 : M ^ 2 =
    !![0, -1, 0, 0, 0, 1;
       0, -1, -1, 0, 0, 0;
       1, 0, 0, -1, -1, 0;
       0, 0, -1, 0, 0, 0;
       1, 0, 0, 0, -1, 0;
       1, 0, 0, 0, 0, 0] := by
  decide

private theorem M_pow4 : M ^ 4 =
    !![1, 1, 1, 0, 0, 0;
       -1, 1, 1, 1, 1, 0;
       -1, -1, 1, 0, 1, 1;
       -1, 0, 0, 1, 1, 0;
       -1, -1, 0, 0, 1, 1;
       0, -1, 0, 0, 0, 1] := by
  calc
    M ^ 4 = (M ^ 2) ^ 2 := pow_mul M 2 2
    _ = _ := by rw [M_pow2]; decide

private theorem M_pow7 : M ^ 7 =
    !![-3, -2, -1, 1, 2, 1;
       -1, -4, -2, -1, 0, 2;
       1, -1, -3, -1, -2, -1;
       1, -2, -1, -1, -1, 1;
       2, 0, -2, -1, -2, -1;
       1, 1, -1, 0, -1, -1] := by
  calc
    M ^ 7 = M ^ 4 * M ^ 2 * M := by rw [← pow_add, ← pow_succ]
    _ = _ := by rw [M_pow4, M_pow2]; decide

/-- The exact fourteenth power in determinant order `(01,02,03,12,13,23)`. -/
theorem M_pow14 : M ^ 14 =
    !![16, 14, 4, -3, -10, -8;
       6, 24, 14, 6, 1, -10;
       -11, 6, 16, 8, 14, 4;
       -4, 10, 8, 6, 6, -3;
       -14, -1, 10, 7, 14, 6;
       -8, -6, 3, 2, 7, 6] := by
  calc
    M ^ 14 = (M ^ 7) ^ 2 := pow_mul M 7 2
    _ = _ := by rw [M_pow7]; decide

end Pisot
