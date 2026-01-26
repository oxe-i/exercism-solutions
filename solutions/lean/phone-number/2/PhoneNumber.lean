namespace PhoneNumber

def validate : List Char -> Option String
  | '0' :: _                => none
  | '1' :: _                => none
  | _ :: _ :: _ :: '0' :: _ => none
  | _ :: _ :: _ :: '1' :: _ => none
  | xs                      => some xs.asString

def clean (phrase : String) : Option String :=
  let digits := phrase.toList.filter Char.isDigit
  let length := digits.length
  if 10 <= length && length <= 11 then
    if length == 11 then
      match digits with
      | '1' :: xs => validate xs
      | _         => none
    else validate digits
  else none

end PhoneNumber
