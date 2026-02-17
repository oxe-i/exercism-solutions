import Std

namespace WordCount

abbrev Map := Std.HashMap String Nat

private def validChar (char : Char) : Bool :=
  char.isAlphanum || char == '\''

private partial def buildMap (sentence : String.Slice) (map : Map) : Map :=
  match sentence.isEmpty with
  | true  => map
  | false =>
    let word := sentence.takeWhile validChar |>.dropEndWhile (. == '\'')
    let next := sentence.dropPrefix word |>.dropWhile (!Char.isAlphanum ·)
    let acc := map.alter word.copy.toLower (fun
      | none   => some 1
      | some x => some (x + 1)
    )
    buildMap next acc

def countWords (sentence : String) : Std.HashMap String Nat :=
  buildMap (sentence.toSlice.dropWhile (!Char.isAlphanum ·)) {}

end WordCount
