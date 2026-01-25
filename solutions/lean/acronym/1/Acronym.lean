namespace Acronym

def abbreviate (phrase : String) : String :=
  let isSeparator (c : Char) : Bool :=
    c.isWhitespace || c == '-'
  let findLetters (chunk : String) : Option Char :=
    chunk.toSlice.find? Char.isAlpha
      |> (·.map (·.get!))
  let letters := phrase.splitToList isSeparator
    |> (·.filterMap findLetters)
  letters.foldl (·.push ·.toUpper) ""

end Acronym
