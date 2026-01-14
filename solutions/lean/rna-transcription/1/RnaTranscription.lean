namespace RnaTranscription

def complement : Char -> Char
  | 'G' => 'C'
  | 'C' => 'G'
  | 'T' => 'A'
  | 'A' => 'U'
  | _   => default

def toRna : String -> String :=
  String.map complement

end RnaTranscription
