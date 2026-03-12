namespace PhoneNumber

def validate : List Char -> Option String
  | '0' :: _                => none
  | '1' :: _                => none
  | _ :: _ :: _ :: '0' :: _ => none
  | _ :: _ :: _ :: '1' :: _ => none
  | xs                      => some xs.asString

def clean (phrase : String) : Option String :=
  let digits := phrase.toList.filter Char.isDigit
  match digits.length with
  | 10 => validate digits
  | 11 => match digits with
          | '1' :: ds => validate ds
          | _         => none
  | _  => none

end PhoneNumber
