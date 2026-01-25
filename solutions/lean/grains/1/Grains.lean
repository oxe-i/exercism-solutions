namespace Grains

def grains (square : Int) : Option Nat :=
  /-
    `∨` is propositional “or”, while `||` is boolean “or”.
    They are different, `∨` connects two `Prop` (the type of proofs),
    whereas `||` produces a `Bool`.

    In Lean, `if ... then ... else` does not require a `Bool`,
    but a decidable condition. Propositions can be used directly
    because Lean can decide them.

    Booleans are not implicitly converted to propositions.
    If a condition needs to be used in a proof, it is preferable
    to use propositional connectives like `∨`.

    In such cases, it is idiomatic to name the condition (e.g.
    `validSquare`) so it can be reused in a manual proof.
  -/
  if validSquare : square < 1 ∨ square > 64
  then none
  else some (1 <<< (square.toNat - 1))

def totalGrains : Nat :=
  (BitVec.fill 64 true).toNat

end Grains
