import Pisot.MatrixPowers

/-!
# M2B-1 audit

Print all three complete matrix equality statements and their foundational
dependencies as part of the default project build.
-/

#check Pisot.A_pow6
#check Pisot.A_pow14
#check Pisot.M_pow14

#print axioms Pisot.A_pow6
#print axioms Pisot.A_pow14
#print axioms Pisot.M_pow14
