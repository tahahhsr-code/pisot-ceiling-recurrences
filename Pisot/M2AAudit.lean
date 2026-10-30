import Pisot.MatrixStep

/-!
# M2A audit

The default project build prints the transition signatures and the axiom
dependencies of every theorem in MatrixStep. The sequence transitions have
no extra hypotheses, and the determinant identity holds for arbitrary vectors.
-/

#check Pisot.x_step
#check Pisot.wedge_A
#check Pisot.W_step

#print axioms Pisot.x_zero
#print axioms Pisot.x_one
#print axioms Pisot.W_zero
#print axioms Pisot.A_mulVec
#print axioms Pisot.x_step
#print axioms Pisot.M_mulVec
#print axioms Pisot.wedge_A
#print axioms Pisot.W_step
