import Pisot

/-! Independent M6 inspection: no declarations or proofs are added. -/

#print Pisot.B
#print Pisot.u
#print Pisot.candidate590
#print Pisot.candidate592
#print Pisot.ceilingSequence
#print Pisot.A048590
#print Pisot.A048592
#print Pisot.A
#print Pisot.x
#print Pisot.wedgeCoord
#print Pisot.wedge
#print Pisot.W
#print Pisot.M
#print Pisot.maxAbs6
#print Pisot.D

#check Pisot.eq_ceil_div_iff
#check Pisot.u3_ceil_rec
#check Pisot.u4_ceil_rec
#check Pisot.int_ceiling_sequence_unique
#check Pisot.A048590_eq_candidate
#check Pisot.A048592_eq_candidate
#check Pisot.B_zero
#check Pisot.B_one
#check Pisot.B_two
#check Pisot.B_three
#check Pisot.B_rec
#check Pisot.B_rec_int
#check Pisot.B_pos
#check Pisot.B_step
#check Pisot.B_monotone
#check Pisot.B_ratio
#check Pisot.u_zero
#check Pisot.u_succ
#check Pisot.u_pos
#check Pisot.u_rec
#check Pisot.u_rec_of_ge
#check Pisot.u_fifth_rec
#check Pisot.u_fifth_rec_of_ge
#check Pisot.u3_initial
#check Pisot.u4_initial
#check Pisot.candidate590_pos
#check Pisot.candidate592_pos
#check Pisot.candidate590_rec
#check Pisot.candidate592_rec
#check Pisot.candidate_shift
#check Pisot.ceilingSequence_zero
#check Pisot.ceilingSequence_one
#check Pisot.ceilingSequence_rec
#check Pisot.ceilingSequence_rec_int
#check Pisot.ceilingSequence_pos
#check Pisot.A048590_zero
#check Pisot.A048590_one
#check Pisot.A048592_zero
#check Pisot.A048592_one
#check Pisot.A048590_pos
#check Pisot.A048592_pos
#check Pisot.x_iterate
#check Pisot.B_add9
#check Pisot.B_add17
#check Pisot.B_growth6
#check Pisot.B_growth14
#check Pisot.B_second_difference_int
#check Pisot.D_shift_identity
#check Pisot.W0_tail_bounds
#check Pisot.D_tail_strict
#check Pisot.D3_tail
#check Pisot.D4_tail
#check Pisot.D3_finite
#check Pisot.D4_finite
#check Pisot.D3_four
#check Pisot.D3_all
#check Pisot.D4_all
#check Pisot.W_invariant_base_values
#check Pisot.W_invariant_bases
#check Pisot.W_invariant_step
#check Pisot.W_invariant
#check Pisot.W_iterate
#check Pisot.W_step14
#check Pisot.W_maxAbs6_step14
#check Pisot.M_pow14_rowSums
#check Pisot.M_pow14_rowSum_le
#check Pisot.maxAbs6_coord_le
#check Pisot.row_mulVec_natAbs_le
#check Pisot.M_pow14_maxAbs6_le
#check Pisot.A_pow6
#check Pisot.A_pow14
#check Pisot.M_pow14
#check Pisot.x_zero
#check Pisot.x_one
#check Pisot.W_zero
#check Pisot.A_mulVec
#check Pisot.x_step
#check Pisot.M_mulVec
#check Pisot.wedge_A
#check Pisot.W_step
#check Pisot.A048590_fifth_rec
#check Pisot.A048592_fifth_rec

#print axioms Pisot.eq_ceil_div_iff
#print axioms Pisot.u3_ceil_rec
#print axioms Pisot.u4_ceil_rec
#print axioms Pisot.int_ceiling_sequence_unique
#print axioms Pisot.A048590_eq_candidate
#print axioms Pisot.A048592_eq_candidate
#print axioms Pisot.B_zero
#print axioms Pisot.B_one
#print axioms Pisot.B_two
#print axioms Pisot.B_three
#print axioms Pisot.B_rec
#print axioms Pisot.B_rec_int
#print axioms Pisot.B_pos
#print axioms Pisot.B_step
#print axioms Pisot.B_monotone
#print axioms Pisot.B_ratio
#print axioms Pisot.u_zero
#print axioms Pisot.u_succ
#print axioms Pisot.u_pos
#print axioms Pisot.u_rec
#print axioms Pisot.u_rec_of_ge
#print axioms Pisot.u_fifth_rec
#print axioms Pisot.u_fifth_rec_of_ge
#print axioms Pisot.u3_initial
#print axioms Pisot.u4_initial
#print axioms Pisot.candidate590_pos
#print axioms Pisot.candidate592_pos
#print axioms Pisot.candidate590_rec
#print axioms Pisot.candidate592_rec
#print axioms Pisot.candidate_shift
#print axioms Pisot.ceilingSequence_zero
#print axioms Pisot.ceilingSequence_one
#print axioms Pisot.ceilingSequence_rec
#print axioms Pisot.ceilingSequence_rec_int
#print axioms Pisot.ceilingSequence_pos
#print axioms Pisot.A048590_zero
#print axioms Pisot.A048590_one
#print axioms Pisot.A048592_zero
#print axioms Pisot.A048592_one
#print axioms Pisot.A048590_pos
#print axioms Pisot.A048592_pos
#print axioms Pisot.x_iterate
#print axioms Pisot.B_add9
#print axioms Pisot.B_add17
#print axioms Pisot.B_growth6
#print axioms Pisot.B_growth14
#print axioms Pisot.B_second_difference_int
#print axioms Pisot.D_shift_identity
#print axioms Pisot.W0_tail_bounds
#print axioms Pisot.D_tail_strict
#print axioms Pisot.D3_tail
#print axioms Pisot.D4_tail
#print axioms Pisot.D3_finite
#print axioms Pisot.D4_finite
#print axioms Pisot.D3_four
#print axioms Pisot.D3_all
#print axioms Pisot.D4_all
#print axioms Pisot.W_invariant_base_values
#print axioms Pisot.W_invariant_bases
#print axioms Pisot.W_invariant_step
#print axioms Pisot.W_invariant
#print axioms Pisot.W_iterate
#print axioms Pisot.W_step14
#print axioms Pisot.W_maxAbs6_step14
#print axioms Pisot.M_pow14_rowSums
#print axioms Pisot.M_pow14_rowSum_le
#print axioms Pisot.maxAbs6_coord_le
#print axioms Pisot.row_mulVec_natAbs_le
#print axioms Pisot.M_pow14_maxAbs6_le
#print axioms Pisot.A_pow6
#print axioms Pisot.A_pow14
#print axioms Pisot.M_pow14
#print axioms Pisot.x_zero
#print axioms Pisot.x_one
#print axioms Pisot.W_zero
#print axioms Pisot.A_mulVec
#print axioms Pisot.x_step
#print axioms Pisot.M_mulVec
#print axioms Pisot.wedge_A
#print axioms Pisot.W_step
#print axioms Pisot.A048590_fifth_rec
#print axioms Pisot.A048592_fifth_rec

/-! Read-only explicit type checks: no new declarations or proofs. -/
#check (Pisot.A048590_fifth_rec : ∀ n : ℕ, 6 ≤ n →
  (Pisot.A048590 n : ℤ) =
    2 * (Pisot.A048590 (n - 1) : ℤ) - (Pisot.A048590 (n - 2) : ℤ) +
    (Pisot.A048590 (n - 4) : ℤ) - (Pisot.A048590 (n - 5) : ℤ))
#check (Pisot.A048592_fifth_rec : ∀ n : ℕ, 6 ≤ n →
  (Pisot.A048592 n : ℤ) =
    2 * (Pisot.A048592 (n - 1) : ℤ) - (Pisot.A048592 (n - 2) : ℤ) +
    (Pisot.A048592 (n - 4) : ℤ) - (Pisot.A048592 (n - 5) : ℤ))
#check (Pisot.A048590_eq_candidate : ∀ n : ℕ,
  (Pisot.A048590 n : ℤ) = Pisot.candidate590 n)
#check (Pisot.A048592_eq_candidate : ∀ n : ℕ,
  (Pisot.A048592 n : ℤ) = Pisot.candidate592 n)
#check (Pisot.ceilingSequence_rec : ∀ a b n : ℕ,
  Pisot.ceilingSequence a b (n + 2) =
    Nat.ceil ((Pisot.ceilingSequence a b (n + 1) : ℚ) ^ 2 /
      (Pisot.ceilingSequence a b n : ℚ)))
#check (Pisot.eq_ceil_div_iff : ∀ v q d : ℤ, 0 < d →
  (v = Int.ceil ((q : ℚ) / (d : ℚ)) ↔ 0 ≤ v * d - q ∧ v * d - q < d))
#check (Pisot.D3_all : ∀ j : ℕ,
  0 ≤ Pisot.u 3 (j + 2) * Pisot.u 3 j - (Pisot.u 3 (j + 1)) ^ 2 ∧
  Pisot.u 3 (j + 2) * Pisot.u 3 j - (Pisot.u 3 (j + 1)) ^ 2 < Pisot.u 3 j)
#check (Pisot.D4_all : ∀ j : ℕ,
  0 ≤ Pisot.u 4 (j + 2) * Pisot.u 4 j - (Pisot.u 4 (j + 1)) ^ 2 ∧
  Pisot.u 4 (j + 2) * Pisot.u 4 j - (Pisot.u 4 (j + 1)) ^ 2 < Pisot.u 4 j)
