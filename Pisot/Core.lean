import Mathlib

/-!
# M1: exact sequences and elementary recurrence lemmas

`B k` is the manuscript's `b_(k+1)`, so `B 0 = 6`. It is not `c_0 - 3`.
The core is natural-valued. Shifted candidates are integer-valued so that
all subtractions in their recurrence identities are ordinary integer subtraction.
No identification of the candidates with the original ceiling sequences is
asserted in this file; that requires the later determinant argument.
-/
namespace Pisot

/-- Fourth-order core, with the manuscript's index shifted by one. -/
def B : ℕ → ℕ
  | 0 => 6
  | 1 => 8
  | 2 => 11
  | 3 => 15
  | n + 4 => B (n + 3) + B n

@[simp] theorem B_zero : B 0 = 6 := rfl
@[simp] theorem B_one : B 1 = 8 := rfl
@[simp] theorem B_two : B 2 = 11 := rfl
@[simp] theorem B_three : B 3 = 15 := rfl

theorem B_rec (n : ℕ) : B (n + 4) = B (n + 3) + B n := by rw [B]

/-- The same recurrence, cast to the integers for later determinant algebra. -/
theorem B_rec_int (n : ℕ) : (B (n + 4) : ℤ) = (B (n + 3) : ℤ) + B n := by
  exact_mod_cast B_rec n

theorem B_pos (n : ℕ) : 0 < B n := by
  induction n using Nat.strong_induction_on with
  | h n ih =>
    by_cases hn : n < 4
    · interval_cases n <;> norm_num [B]
    · obtain ⟨k, rfl⟩ : ∃ k, n = k + 4 := ⟨n - 4, by omega⟩
      rw [B_rec]
      exact Nat.add_pos_left (ih (k + 3) (by omega)) _

theorem B_step (n : ℕ) : B n < B (n + 1) := by
  by_cases hn : n < 3
  · interval_cases n <;> norm_num [B]
  · obtain ⟨k, rfl⟩ : ∃ k, n = k + 3 := ⟨n - 3, by omega⟩
    have hp := B_pos k
    have hr := B_rec k
    convert (show B (k + 3) < B (k + 4) by omega) using 1

theorem B_monotone : Monotone B :=
  monotone_nat_of_le_succ (fun n => (B_step n).le)

theorem B_ratio (n : ℕ) : B (n + 1) ≤ 2 * B n := by
  by_cases hn : n < 3
  · interval_cases n <;> norm_num [B]
  · obtain ⟨k, rfl⟩ : ∃ k, n = k + 3 := ⟨n - 3, by omega⟩
    have hm : B k ≤ B (k + 3) := B_monotone (by omega)
    have hr := B_rec k
    convert (show B (k + 4) ≤ 2 * B (k + 3) by omega) using 1

/-- Generic integer shift; the two candidate sequences have shifts 3 and 4. -/
def u (t : ℤ) : ℕ → ℤ
  | 0 => t + 5
  | n + 1 => (B n : ℤ) + t

@[simp] theorem u_zero (t : ℤ) : u t 0 = t + 5 := rfl
@[simp] theorem u_succ (t : ℤ) (n : ℕ) : u t (n + 1) = (B n : ℤ) + t := rfl

theorem u_pos {t : ℤ} (ht : 0 ≤ t) (n : ℕ) : 0 < u t n := by
  cases n with
  | zero => simp only [u_zero]; omega
  | succ n =>
    simp only [u_succ]
    have hb : (0 : ℤ) < B n := by exact_mod_cast B_pos n
    omega

/-- Fourth-order affine recurrence, valid starting at candidate index 5. -/
theorem u_rec (t : ℤ) (k : ℕ) :
    u t (k + 5) = u t (k + 4) + u t (k + 1) - t := by
  change (B (k + 4) : ℤ) + t = ((B (k + 3) : ℤ) + t) + ((B k : ℤ) + t) - t
  rw [B_rec_int]
  ring

theorem u_rec_of_ge (t : ℤ) (n : ℕ) (hn : 5 ≤ n) :
    u t n = u t (n - 1) + u t (n - 4) - t := by
  obtain ⟨k, rfl⟩ : ∃ k, n = k + 5 := ⟨n - 5, by omega⟩
  simpa using u_rec t k

/-- Fifth-order identity for the candidates only. No ceiling claim is used. -/
theorem u_fifth_rec (t : ℤ) (k : ℕ) :
    u t (k + 6) = 2 * u t (k + 5) - u t (k + 4) + u t (k + 2) - u t (k + 1) := by
  have h0 := u_rec t k
  have h1 := u_rec t (k + 1)
  simp only [Nat.add_assoc] at h1
  linarith

theorem u_fifth_rec_of_ge (t : ℤ) (n : ℕ) (hn : 6 ≤ n) :
    u t n = 2 * u t (n - 1) - u t (n - 2) + u t (n - 4) - u t (n - 5) := by
  obtain ⟨k, rfl⟩ : ∃ k, n = k + 6 := ⟨n - 6, by omega⟩
  simpa using u_fifth_rec t k

def candidate590 : ℕ → ℤ := u 3
def candidate592 : ℕ → ℤ := u 4

theorem u3_initial : (u 3 0, u 3 1, u 3 2, u 3 3, u 3 4, u 3 5, u 3 6) =
    (8, 9, 11, 14, 18, 24, 32) := by norm_num [u, B]

theorem u4_initial : (u 4 0, u 4 1, u 4 2, u 4 3, u 4 4, u 4 5, u 4 6) =
    (9, 10, 12, 15, 19, 25, 33) := by norm_num [u, B]

theorem candidate590_pos (n : ℕ) : 0 < candidate590 n := u_pos (by norm_num) n
theorem candidate592_pos (n : ℕ) : 0 < candidate592 n := u_pos (by norm_num) n

theorem candidate590_rec (n : ℕ) (hn : 6 ≤ n) :
    candidate590 n = 2 * candidate590 (n - 1) - candidate590 (n - 2) +
      candidate590 (n - 4) - candidate590 (n - 5) := u_fifth_rec_of_ge 3 n hn

theorem candidate592_rec (n : ℕ) (hn : 6 ≤ n) :
    candidate592 n = 2 * candidate592 (n - 1) - candidate592 (n - 2) +
      candidate592 (n - 4) - candidate592 (n - 5) := u_fifth_rec_of_ge 4 n hn

/-- The second candidate is exactly the first plus one, at every index. -/
theorem candidate_shift (n : ℕ) : candidate592 n = candidate590 n + 1 := by
  cases n with
  | zero => rfl
  | succ n =>
    change (B n : ℤ) + 4 = ((B n : ℤ) + 3) + 1
    ring

/-- Original nonlinear sequence: the quotient is rational and rounding is upward.
Its positivity, proved below, ensures natural ceiling is the usual integer ceiling. -/
def ceilingSequence (a b : ℕ) : ℕ → ℕ
  | 0 => a
  | 1 => b
  | n + 2 => ⌈(ceilingSequence a b (n + 1) : ℚ) ^ 2 /
      (ceilingSequence a b n : ℚ)⌉₊

@[simp] theorem ceilingSequence_zero (a b : ℕ) : ceilingSequence a b 0 = a := rfl
@[simp] theorem ceilingSequence_one (a b : ℕ) : ceilingSequence a b 1 = b := rfl

theorem ceilingSequence_rec (a b n : ℕ) :
    ceilingSequence a b (n + 2) =
      ⌈(ceilingSequence a b (n + 1) : ℚ)^2 / (ceilingSequence a b n : ℚ)⌉₊ := by
  rw [ceilingSequence]

/-- On the nonnegative rational quotient, natural and integer ceilings agree. -/
theorem ceilingSequence_rec_int (a b n : ℕ) :
    (ceilingSequence a b (n + 2) : ℤ) =
      ⌈(ceilingSequence a b (n + 1) : ℚ)^2 / (ceilingSequence a b n : ℚ)⌉ := by
  rw [ceilingSequence_rec]
  apply Int.natCast_ceil_eq_ceil
  positivity

theorem ceilingSequence_pos {a b : ℕ} (ha : 0 < a) (hb : 0 < b) (n : ℕ) :
    0 < ceilingSequence a b n := by
  induction n using Nat.strong_induction_on with
  | h n ih =>
    by_cases hn : n < 2
    · interval_cases n
      · simpa using ha
      · simpa using hb
    · obtain ⟨k, rfl⟩ : ∃ k, n = k + 2 := ⟨n - 2, by omega⟩
      rw [ceilingSequence_rec, Nat.ceil_pos]
      have h0 := ih k (by omega)
      have h1 := ih (k + 1) (by omega)
      positivity

def A048590 : ℕ → ℕ := ceilingSequence 8 9
def A048592 : ℕ → ℕ := ceilingSequence 9 10

@[simp] theorem A048590_zero : A048590 0 = 8 := rfl
@[simp] theorem A048590_one : A048590 1 = 9 := rfl
@[simp] theorem A048592_zero : A048592 0 = 9 := rfl
@[simp] theorem A048592_one : A048592 1 = 10 := rfl

theorem A048590_pos (n : ℕ) : 0 < A048590 n :=
  ceilingSequence_pos (by norm_num) (by norm_num) n

theorem A048592_pos (n : ℕ) : 0 < A048592 n :=
  ceilingSequence_pos (by norm_num) (by norm_num) n

end Pisot
