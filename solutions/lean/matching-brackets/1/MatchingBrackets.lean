namespace MatchingBrackets

def validate : List Char -> Char -> Option (List Char)
  | '(' :: ss, ')' => some ss
  | '[' :: ss, ']' => some ss
  | '{' :: ss, '}' => some ss
  | _, ')'         => none
  | _, ']'         => none
  | _, '}'         => none
  | ss, '('        => some ('(' :: ss)
  | ss, '['        => some ('[' :: ss)
  | ss, '{'        => some ('{' :: ss)
  | ss, _          => some ss

def isPaired (value : String) : Bool :=
  match value.toList.foldlM validate [] with
  | some [] => true
  | _       => false

end MatchingBrackets
