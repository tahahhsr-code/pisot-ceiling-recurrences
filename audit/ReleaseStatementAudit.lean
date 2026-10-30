import Pisot

/-! Mission 2 independently written contract checks. No new declarations. -/
#check (Pisot.A048590_zero : Pisot.A048590 0 = 8)
#check (Pisot.A048590_one : Pisot.A048590 1 = 9)
#check (Pisot.A048592_zero : Pisot.A048592 0 = 9)
#check (Pisot.A048592_one : Pisot.A048592 1 = 10)
#check (Pisot.A048590_pos : ∀ n : ℕ, 0 < Pisot.A048590 n)
#check (Pisot.A048592_pos : ∀ n : ℕ, 0 < Pisot.A048592 n)
#check (Pisot.ceilingSequence_rec : ∀ a b n : ℕ,
  Pisot.ceilingSequence a b (n+2) =
    Nat.ceil ((Pisot.ceilingSequence a b (n+1) : ℚ)^2 /
      (Pisot.ceilingSequence a b n : ℚ)))
#check (Pisot.A048590_eq_candidate : ∀ n : ℕ,
  (Pisot.A048590 n : ℤ) = Pisot.candidate590 n)
#check (Pisot.A048592_eq_candidate : ∀ n : ℕ,
  (Pisot.A048592 n : ℤ) = Pisot.candidate592 n)
#check (Pisot.A048590_fifth_rec : ∀ n : ℕ, 6 ≤ n →
  (Pisot.A048590 n : ℤ) = 2*(Pisot.A048590 (n-1) : ℤ) -
    (Pisot.A048590 (n-2) : ℤ) + (Pisot.A048590 (n-4) : ℤ) -
    (Pisot.A048590 (n-5) : ℤ))
#check (Pisot.A048592_fifth_rec : ∀ n : ℕ, 6 ≤ n →
  (Pisot.A048592 n : ℤ) = 2*(Pisot.A048592 (n-1) : ℤ) -
    (Pisot.A048592 (n-2) : ℤ) + (Pisot.A048592 (n-4) : ℤ) -
    (Pisot.A048592 (n-5) : ℤ))
#check (Pisot.W_invariant_bases : ∀ j ∈ Finset.range 14,
  Pisot.maxAbs6 (Pisot.W (j+15)) ≤ Pisot.B (j+11))
#check (Pisot.W_invariant : ∀ j : ℕ,
  Pisot.maxAbs6 (Pisot.W (j+15)) ≤ Pisot.B (j+11))
#check (Pisot.D3_all : ∀ j : ℕ, 0 ≤ Pisot.D 3 j ∧ Pisot.D 3 j < Pisot.u 3 j)
#check (Pisot.D4_all : ∀ j : ℕ, 0 ≤ Pisot.D 4 j ∧ Pisot.D 4 j < Pisot.u 4 j)
#check (Pisot.D3_four : Pisot.D 3 4 = 0)
#print axioms Pisot.A048590_fifth_rec
#print axioms Pisot.A048592_fifth_rec
#print axioms Pisot.A048590_eq_candidate
#print axioms Pisot.A048592_eq_candidate
#print axioms Pisot.W_invariant
#print axioms Pisot.D3_all
#print axioms Pisot.D4_all
#print axioms Pisot.eq_ceil_div_iff
