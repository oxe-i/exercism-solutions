namespace Acronym

private def isSeparator (c : Char) : Bool :=
    c.isWhitespace || c == '-'

private def findLetters (chunk : String) : Option Char :=
  chunk.toSlice.find? Char.isAlpha
    |>.map (·.get!)

def abbreviate (phrase : String) : String :=
  phrase.splitToList isSeparator
    |>.filterMap findLetters
    |>.foldl (·.push ·.toUpper) ""

end Acronym
