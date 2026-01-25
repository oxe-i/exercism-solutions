namespace EliudsEggs

def eggCount (number : Nat) : Nat :=
  let bitLength := number.log2
  let rec helper (bits : Nat) :=
    if bits = 0 then 0
    else
      let tz := (BitVec.ofNat bitLength bits).ctz.toNat
      let shifted := bits >>> tz
      have shiftedLTEBits : shifted <= bits := by
        exact Nat.shiftRight_le bits tz -- bits >>> tz <= bits
      1 + helper (shifted - 1)
    termination_by bits
    decreasing_by grind
    /-
        bits > 0 ∧ bits >>> tz <= bits → bits >>> tz > 0
        bits >>> tz > 0 ∧ n > 0 → n - 1 < n → (bits >>> tz) - 1 < (bits >>> tz)
        bits >>> tz <= bits ∧ (bits >>> tz) - 1 < (bits >>> tz) → (bits >>> tz) - 1 < bits
        which is enough to prove termination (the parameter is always decreasing in the recursive branch)

        grind does this "logical math" automatically, once we provide:
        1. ¬(bits = 0), which follows from if...else.
        2. shiftedLTEBits, which we had to prove manually.
    -/
  helper number

end EliudsEggs
