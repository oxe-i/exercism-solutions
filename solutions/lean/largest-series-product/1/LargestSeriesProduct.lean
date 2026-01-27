namespace LargestSeriesProduct

def toDigit (digit : Char) : Nat :=
  digit.toNat - '0'.toNat

def getLargest (span : Nat) (digits : String) (pos largest : Nat) : Option Nat :=
  let slice := (digits.toSlice.drop pos).take span
  slice.chars.foldM (fun acc c =>
    if c.isDigit
    then some $ acc * toDigit c
    else none
  ) 1 |> (·.map $ max largest)

def largestProduct (span : Nat) (digits : String) : Option Nat :=
  if span > digits.length then none
  else
    let numWindows := digits.length + 1 - span
    (0...numWindows).toList.foldrM (getLargest span digits) 0

end LargestSeriesProduct
