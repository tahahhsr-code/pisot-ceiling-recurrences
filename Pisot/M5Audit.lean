import Pisot.OriginalRecurrences

/-! Audit the original definitions, their ceiling semantics, and every M5 theorem. -/

#print Pisot.A048590
#print Pisot.A048592
#print Pisot.ceilingSequence
#print Pisot.candidate590
#print Pisot.candidate592
#print Pisot.u
#check Pisot.A048590_zero
#check Pisot.A048590_one
#check Pisot.A048592_zero
#check Pisot.A048592_one
#check Pisot.A048590_pos
#check Pisot.A048592_pos
#check Pisot.ceilingSequence_rec
#check Pisot.ceilingSequence_rec_int
#check Pisot.u3_initial
#check Pisot.u4_initial
#check Pisot.u_pos

#check Pisot.eq_ceil_div_iff
#check Pisot.u3_ceil_rec
#check Pisot.u4_ceil_rec
#check Pisot.int_ceiling_sequence_unique
#check Pisot.A048590_eq_candidate
#check Pisot.A048592_eq_candidate
#check Pisot.A048590_fifth_rec
#check Pisot.A048592_fifth_rec

#print axioms Pisot.eq_ceil_div_iff
#print axioms Pisot.u3_ceil_rec
#print axioms Pisot.u4_ceil_rec
#print axioms Pisot.int_ceiling_sequence_unique
#print axioms Pisot.A048590_eq_candidate
#print axioms Pisot.A048592_eq_candidate
#print axioms Pisot.A048590_fifth_rec
#print axioms Pisot.A048592_fifth_rec
