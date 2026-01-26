namespace SquareRoot

def babylonianRoot (radicand guess : Float) (fuel : Nat) : Float :=
  match fuel with
  | 0 => guess
  | fuel' + 1 =>
    if Float.abs (radicand - guess * guess) < 0.001
    then guess
    else
      let newGuess := (guess + radicand / guess) / 2
      babylonianRoot radicand newGuess fuel'

def squareRoot (radicand : Nat) : Nat :=
  let root := babylonianRoot radicand.toFloat 1.0 10
  root.toUInt64.toNat

end SquareRoot
