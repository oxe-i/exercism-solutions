import Std

namespace ParallelLetterFrequency

def countText (text : String) : Std.TreeMap Char Nat :=
  text.foldl (fun acc ch =>
    if ch.isAlpha
    then acc.alter ch.toLower (fun
          | none   => some 1
          | some v => some (v + 1)
        )
    else acc
  ) {}

def calculateFrequencies (texts : List String) : IO (Std.TreeMap Char Nat) :=
  let tasks := texts.map (λ text => Task.spawn (λ _ => countText text))
  IO.wait (Task.mapList (·.foldl (·.mergeWith (λ _ v1 v2 => v1 + v2) ·) {}) tasks)

end ParallelLetterFrequency
