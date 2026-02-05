namespace NthPrime

def prime (n : Nat) : Option Nat := do
  guard (n ≠ 0)

  let logn := n.log2
  let loglogn := if logn > 1 then logn.log2 else 1
  let upperBound := if n < 6 then 15 else n * (logn + loglogn)

  let mut table := Array.replicate upperBound true
  let mut count := 0

  for p in [2:upperBound] do
    if table[p]! then
      count := count + 1
      if count == n then
        return p
      let mut i := p * p
      while i < upperBound do
        table := table.set! i false
        i := i + p
  none

end NthPrime
