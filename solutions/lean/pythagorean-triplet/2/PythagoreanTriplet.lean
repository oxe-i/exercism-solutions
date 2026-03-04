namespace PythagoreanTriplet

def tripletsWithSum (sum : Nat) : List (List Nat) :=
  if 2 ∣ sum then
    List.range' 2 sum
      |>.takeWhile (fun m => 2*m*(m + 1) ≤ sum)
      |>.flatMap (fun m =>
        List.range' 1 m
          |>.filterMap (fun n => do
            guard ¬(2 ∣ (m - n))
            guard (Nat.gcd m n = 1)

            let s := 2*m*(m + n)
            guard (s ∣ sum)

            let k := sum / s

            let a := k * (m * m - n * n)
            let b := k * (2 * m * n)
            let c := k * (m * m + n * n)

            let triplet := if a <= b then [a, b, c] else [b, a, c]
            return triplet
          )
      )
      |>.mergeSort
  else []

end PythagoreanTriplet
