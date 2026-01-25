namespace Hamming

def distance (strand1 : String) (strand2 : String) : Option Nat :=
  if strand1.length ≠ strand2.length
  then none
  else strand1.toList.zip strand2.toList
        |> (·.foldl (λ sum (n1, n2) => sum + (n1 != n2).toNat) 0)
        |> some

end Hamming
