namespace Matrix

def getMatrix (xs : String) : List (List Nat) :=
  xs.splitOn "\n"
    |> List.map (λ row => row.splitOn " " |> List.filterMap String.toNat?)

def row (xs : String) (n : Nat) : List Nat :=
  let matrix := getMatrix xs
  matrix[n - 1]! -- assume index is in bounds

def column (xs : String) (n : Nat) : List Nat :=
  let matrix := getMatrix xs
  matrix.foldr (λ row acc => row[n - 1]! :: acc) [] -- assume index is in bounds

end Matrix
