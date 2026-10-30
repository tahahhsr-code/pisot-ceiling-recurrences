import Pisot.CeilingIdentification

/-!
# M5B: the original OEIS fifth-order recurrences

These theorems concern the unchanged natural-valued ceiling sequences.
Every sequence value is cast to the integers before the linear arithmetic.
The recurrence begins at index six, including the equality case there.
-/
namespace Pisot

/-- The fifth-order recurrence for the original ceiling sequence starting with eight and nine. -/
theorem A048590_fifth_rec (n : ℕ) (hn : 6 ≤ n) :
    (A048590 n : ℤ) =
      2 * (A048590 (n - 1) : ℤ) -
      (A048590 (n - 2) : ℤ) +
      (A048590 (n - 4) : ℤ) -
      (A048590 (n - 5) : ℤ) := by
  simpa only [A048590_eq_candidate] using candidate590_rec n hn

/-- The fifth-order recurrence for the original ceiling sequence starting with nine and ten. -/
theorem A048592_fifth_rec (n : ℕ) (hn : 6 ≤ n) :
    (A048592 n : ℤ) =
      2 * (A048592 (n - 1) : ℤ) -
      (A048592 (n - 2) : ℤ) +
      (A048592 (n - 4) : ℤ) -
      (A048592 (n - 5) : ℤ) := by
  simpa only [A048592_eq_candidate] using candidate592_rec n hn

end Pisot
