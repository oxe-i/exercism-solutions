namespace SumOfMultiples

def sum (factors : List UInt64) (limit : UInt64) : UInt64 :=
  (List.range limit.toNat).foldl (fun acc n =>
    if factors.any (λ f => n % f.toNat == 0)
    then acc + n.toUInt64
    else acc
  ) 0

end SumOfMultiples
