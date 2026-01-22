namespace ReverseString

def reverse : String -> String :=
  String.foldr (flip String.push) ""

end ReverseString
