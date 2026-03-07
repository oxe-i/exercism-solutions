namespace AffineCipher

private def A := 'a'.toNat
private def mmis : Vector (Option (Fin 26)) 26 :=
  (Vector.finRange 26).map fun idx =>
    (List.finRange 26).find? fun x => x * idx = 1

private def mod26 (x : Nat) : Fin 26 := ⟨x % 26, by omega⟩
private def toIdx (ch : Char) : Fin 26 := ⟨(ch.toLower.toNat - A) % 26, by omega⟩
private def toChar (x : Fin 26) : Char := Char.ofNat (x.val + A)
private def encodeChar (a b : Fin 26) (ch : Char) : Fin 26 := a * toIdx ch + b
private def decodeChar (mmi b : Fin 26) (ch : Char) : Fin 26 := mmi * (toIdx ch - b)

def encode (phrase : String) (a : Nat) (b : Nat) : Option String := do
  let a := mod26 a
  let b := mod26 b
  discard (mmis[a])  -- early return if mmis[i] is none, i.e., a and 26 are not coprime

  let (encoded, _) := phrase.foldl
    (fun (acc, count) ch =>
      if ch.isAlphanum
      then
        let letter := if ch.isAlpha
          then toChar (encodeChar a b ch)
          else ch
        if count = 5
        then ((acc.push ' ').push letter, 1)
        else (acc.push letter, count + 1)
      else (acc, count)
    ) (init := ("", 0))
  return encoded

def decode (phrase : String) (a : Nat) (b : Nat) : Option String := do
  let a := mod26 a
  let b := mod26 b
  let mmi ← mmis[a] -- early return if mmis[i] is none, i.e., a and 26 are not coprime

  return phrase.foldl
    (fun acc ch =>
      if ch.isDigit
      then acc.push ch
      else if ch.isAlpha
      then
        let letter := toChar (decodeChar mmi b ch)
        acc.push letter
      else acc
    ) (init := "")

end AffineCipher
