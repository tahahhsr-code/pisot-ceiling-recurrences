import Pisot.MatrixIteration
import Pisot.CoreGrowth

/-!
# M3B: fourteen bases and the determinant invariant

`W (j+15)` is manuscript `W_(j+20)`, and `B (j+11)` is `b_(j+12)`.
The finite certificate is proved by the verified recurrences, with each
displayed vector, core value, and absolute maximum checked by Lean.
-/
namespace Pisot

private theorem W_base_vectors :
    (fun j : Fin 14 => W (j.val + 15)) =
      ![![-76, 123, 192, 129, 168, 54],
        ![-192, -244, 69, -76, 123, 129],
        ![-69, -315, -373, -192, -244, -76],
        ![373, 175, -239, -69, -315, -192],
        ![239, 688, 367, 373, 175, -69],
        ![-367, 64, 757, 239, 688, 373],
        ![-757, -1055, -309, -367, 64, 239],
        ![309, -821, -1294, -757, -1055, -367],
        ![1294, 1364, -454, 309, -821, -757],
        ![454, 2115, 2121, 1294, 1364, 309],
        ![-2121, -910, 1806, 454, 2115, 1294],
        ![-1806, -4236, -2204, -2121, -910, 454],
        ![2204, -896, -4690, -1806, -4236, -2121],
        ![4690, 6440, 1225, 2204, -896, -1806]] := by
  have h0 : W 0 = ![6, 3, 6, -1, 2, 2] := W_zero
  have h1 : W 1 = ![-6, 4, 1, 6, 3, -1] := by
    rw [W_step 0, h0, M_mulVec]
    decide
  have h2 : W 2 = ![-1, -9, 5, -6, 4, 6] := by
    rw [W_step 1, h1, M_mulVec]
    decide
  have h3 : W 3 = ![-5, -5, -15, -1, -9, -6] := by
    rw [W_step 2, h2, M_mulVec]
    decide
  have h4 : W 4 = ![15, 4, 1, -5, -5, -1] := by
    rw [W_step 3, h3, M_mulVec]
    decide
  have h5 : W 5 = ![-1, 20, 5, 15, 4, -5] := by
    rw [W_step 4, h4, M_mulVec]
    decide
  have h6 : W 6 = ![-5, -5, 25, -1, 20, 15] := by
    rw [W_step 5, h5, M_mulVec]
    decide
  have h7 : W 7 = ![-25, -25, -20, -5, -5, -1] := by
    rw [W_step 6, h6, M_mulVec]
    decide
  have h8 : W 8 = ![20, -20, -24, -25, -25, -5] := by
    rw [W_step 7, h7, M_mulVec]
    decide
  have h9 : W 9 = ![24, 45, -15, 20, -20, -25] := by
    rw [W_step 8, h8, M_mulVec]
    decide
  have h10 : W 10 = ![15, 44, 70, 24, 45, 20] := by
    rw [W_step 9, h9, M_mulVec]
    decide
  have h11 : W 11 = ![-70, -30, 24, 15, 44, 24] := by
    rw [W_step 10, h10, M_mulVec]
    decide
  have h12 : W 12 = ![-24, -114, -54, -70, -30, 15] := by
    rw [W_step 11, h11, M_mulVec]
    decide
  have h13 : W 13 = ![54, 6, -129, -24, -114, -70] := by
    rw [W_step 12, h12, M_mulVec]
    decide
  have h14 : W 14 = ![129, 168, 76, 54, 6, -24] := by
    rw [W_step 13, h13, M_mulVec]
    decide
  have h15 : W 15 = ![-76, 123, 192, 129, 168, 54] := by
    rw [W_step 14, h14, M_mulVec]
    decide
  have h16 : W 16 = ![-192, -244, 69, -76, 123, 129] := by
    rw [W_step 15, h15, M_mulVec]
    decide
  have h17 : W 17 = ![-69, -315, -373, -192, -244, -76] := by
    rw [W_step 16, h16, M_mulVec]
    decide
  have h18 : W 18 = ![373, 175, -239, -69, -315, -192] := by
    rw [W_step 17, h17, M_mulVec]
    decide
  have h19 : W 19 = ![239, 688, 367, 373, 175, -69] := by
    rw [W_step 18, h18, M_mulVec]
    decide
  have h20 : W 20 = ![-367, 64, 757, 239, 688, 373] := by
    rw [W_step 19, h19, M_mulVec]
    decide
  have h21 : W 21 = ![-757, -1055, -309, -367, 64, 239] := by
    rw [W_step 20, h20, M_mulVec]
    decide
  have h22 : W 22 = ![309, -821, -1294, -757, -1055, -367] := by
    rw [W_step 21, h21, M_mulVec]
    decide
  have h23 : W 23 = ![1294, 1364, -454, 309, -821, -757] := by
    rw [W_step 22, h22, M_mulVec]
    decide
  have h24 : W 24 = ![454, 2115, 2121, 1294, 1364, 309] := by
    rw [W_step 23, h23, M_mulVec]
    decide
  have h25 : W 25 = ![-2121, -910, 1806, 454, 2115, 1294] := by
    rw [W_step 24, h24, M_mulVec]
    decide
  have h26 : W 26 = ![-1806, -4236, -2204, -2121, -910, 454] := by
    rw [W_step 25, h25, M_mulVec]
    decide
  have h27 : W 27 = ![2204, -896, -4690, -1806, -4236, -2121] := by
    rw [W_step 26, h26, M_mulVec]
    decide
  have h28 : W 28 = ![4690, 6440, 1225, 2204, -896, -1806] := by
    rw [W_step 27, h27, M_mulVec]
    decide
  funext j
  fin_cases j
  · exact h15
  · exact h16
  · exact h17
  · exact h18
  · exact h19
  · exact h20
  · exact h21
  · exact h22
  · exact h23
  · exact h24
  · exact h25
  · exact h26
  · exact h27
  · exact h28

private theorem B_base_values :
    (fun j : Fin 14 => B (j.val + 11)) =
      ![200, 276, 381, 526, 726, 1002, 1383, 1909, 2635, 3637, 5020, 6929, 9564, 13201] := by
  have h0 : B 0 = 6 := B_zero
  have h1 : B 1 = 8 := B_one
  have h2 : B 2 = 11 := B_two
  have h3 : B 3 = 15 := B_three
  have h4 : B 4 = 21 := by
    rw [B_rec 0, h3, h0]
  have h5 : B 5 = 29 := by
    rw [B_rec 1, h4, h1]
  have h6 : B 6 = 40 := by
    rw [B_rec 2, h5, h2]
  have h7 : B 7 = 55 := by
    rw [B_rec 3, h6, h3]
  have h8 : B 8 = 76 := by
    rw [B_rec 4, h7, h4]
  have h9 : B 9 = 105 := by
    rw [B_rec 5, h8, h5]
  have h10 : B 10 = 145 := by
    rw [B_rec 6, h9, h6]
  have h11 : B 11 = 200 := by
    rw [B_rec 7, h10, h7]
  have h12 : B 12 = 276 := by
    rw [B_rec 8, h11, h8]
  have h13 : B 13 = 381 := by
    rw [B_rec 9, h12, h9]
  have h14 : B 14 = 526 := by
    rw [B_rec 10, h13, h10]
  have h15 : B 15 = 726 := by
    rw [B_rec 11, h14, h11]
  have h16 : B 16 = 1002 := by
    rw [B_rec 12, h15, h12]
  have h17 : B 17 = 1383 := by
    rw [B_rec 13, h16, h13]
  have h18 : B 18 = 1909 := by
    rw [B_rec 14, h17, h14]
  have h19 : B 19 = 2635 := by
    rw [B_rec 15, h18, h15]
  have h20 : B 20 = 3637 := by
    rw [B_rec 16, h19, h16]
  have h21 : B 21 = 5020 := by
    rw [B_rec 17, h20, h17]
  have h22 : B 22 = 6929 := by
    rw [B_rec 18, h21, h18]
  have h23 : B 23 = 9564 := by
    rw [B_rec 19, h22, h19]
  have h24 : B 24 = 13201 := by
    rw [B_rec 20, h23, h20]
  funext j
  fin_cases j
  · exact h11
  · exact h12
  · exact h13
  · exact h14
  · exact h15
  · exact h16
  · exact h17
  · exact h18
  · exact h19
  · exact h20
  · exact h21
  · exact h22
  · exact h23
  · exact h24

/-- Exact certificate for every manuscript base index from 20 through 33. -/
theorem W_invariant_base_values (j : Fin 14) :
    (maxAbs6 (W (j.val + 15)), B (j.val + 11)) =
      ![(192, 200), (244, 276), (373, 381), (373, 526),
        (688, 726), (757, 1002), (1055, 1383), (1294, 1909),
        (1364, 2635), (2121, 3637), (2121, 5020), (4236, 6929),
        (4690, 9564), (6440, 13201)] j := by
  rw [congrFun W_base_vectors j, congrFun B_base_values j]
  fin_cases j <;> decide

/-- All fourteen bases, with the original additive indexing. -/
theorem W_invariant_bases :
    ∀ j ∈ Finset.range 14, maxAbs6 (W (j + 15)) ≤ B (j + 11) := by
  intro j hj
  have hjlt : j < 14 := Finset.mem_range.mp hj
  have h := W_invariant_base_values ⟨j, hjlt⟩
  have htable : ∀ i : Fin 14,
      (![(192, 200), (244, 276), (373, 381), (373, 526),
        (688, 726), (757, 1002), (1055, 1383), (1294, 1909),
        (1364, 2635), (2121, 3637), (2121, 5020), (4236, 6929),
        (4690, 9564), (6440, 13201)] i).1 ≤
      (![(192, 200), (244, 276), (373, 381), (373, 526),
        (688, 726), (757, 1002), (1055, 1383), (1294, 1909),
        (1364, 2635), (2121, 3637), (2121, 5020), (4236, 6929),
        (4690, 9564), (6440, 13201)] i).2 := by decide
  have hi := htable ⟨j, hjlt⟩
  rw [← h] at hi
  exact hi

/-- Propagate the determinant invariant through one block of fourteen indices. -/
theorem W_invariant_step (j : ℕ)
    (h : maxAbs6 (W (j + 15)) ≤ B (j + 11)) :
    maxAbs6 (W ((j + 14) + 15)) ≤ B ((j + 14) + 11) := by
  have hw : maxAbs6 (W (j + 29)) ≤ 61 * maxAbs6 (W (j + 15)) :=
    W_maxAbs6_step14 (j + 15)
  have hb : 141 * B (j + 11) ≤ 2 * B (j + 25) := B_growth14 (j + 8)
  change maxAbs6 (W (j + 29)) ≤ B (j + 25)
  omega

/-- The determinant invariant for every manuscript index at least twenty. -/
theorem W_invariant (j : ℕ) :
    maxAbs6 (W (j + 15)) ≤ B (j + 11) := by
  induction j using Nat.strong_induction_on with
  | h j ih =>
    by_cases hj : j < 14
    · exact W_invariant_bases j (Finset.mem_range.mpr hj)
    · have hprev := ih (j - 14) (by omega)
      have hstep := W_invariant_step (j - 14) hprev
      have heq : (j - 14) + 14 = j := by omega
      simpa only [heq] using hstep

end Pisot
