namespace AllYourBase

def ValidBase := { x : Nat // x ≥ 2 }

theorem ValidBase.gt_zero (x : ValidBase) : 0 < x.val :=
  Nat.lt_of_lt_of_le (by decide) x.property

def outDigits (base : ValidBase) (n : Nat) (acc : List (Fin base.val) := []) : List (Fin base.val) :=
  if h: n ≠ 0 then
    let digit := n % base.val
    let next  := n / base.val
    outDigits base next (⟨digit, Nat.mod_lt _ base.gt_zero⟩ :: acc)
  else acc
termination_by n
decreasing_by
  exact Nat.div_lt_self (Nat.pos_of_ne_zero h) base.property

def rebase (inputBase : ValidBase) (digits : List (Fin inputBase.val)) (outputBase : ValidBase) : List (Fin outputBase.val) :=
  let base10 := digits.foldl (fun acc d => acc * inputBase.val + d.val) 0
  match outDigits outputBase base10 with
  | [] => [⟨0, outputBase.gt_zero⟩]
  | xs => xs

end AllYourBase
