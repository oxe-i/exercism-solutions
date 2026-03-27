namespace RailFenceCipher

def Positive := { x : Nat // x > 0 }

private def orderedIndices (size numRails : Nat) : List Nat :=
  let period := 2 * numRails - 2
  (List.range numRails).flatMap fun rail =>
    (List.range size).filter fun idx =>
      idx % period ∈ #[rail, period - rail]

def encode (rails : Positive) (msg : String) : String :=
  match rails with
  | ⟨1, _⟩ => msg
  | ⟨r, _⟩ =>
    let charsArray := msg.toSlice.chars.toArray
    orderedIndices msg.length r
      |>.filterMap (charsArray[·]?)
      |>.asString -- String.ofList should be used in latest version

def decode (rails : Positive) (msg : String) : String :=
  match rails with
  | ⟨1, _⟩ => msg
  | ⟨r, _⟩ =>
    let indices := orderedIndices msg.length r
    List.zip indices msg.toList
      |>.mergeSort (fun (i₁, _) (i₂, _) => i₁ ≤ i₂)
      |>.map (·.snd)
      |>.asString -- String.ofList should be used in latest version

end RailFenceCipher
