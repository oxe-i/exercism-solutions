import Std

namespace Anagram

def getLetterCount : String -> Std.TreeMap Char Nat :=
  String.foldl (λ acc ch =>
    if ch.isAlpha
    then acc.alter ch (λ
      | none   => some 1
      | some v => some (v + 1)
    )
    else acc
  ) {}

def findAnagrams (subject : String) : List String -> List String :=
  let normalizedSubject := subject.toUpper
  let subjectLetterCount := Std.TreeMap.toList $ getLetterCount normalizedSubject
  List.filter (λ candidate =>
    let normalizedCandidate := candidate.toUpper
    let candidateLetterCount := Std.TreeMap.toList $ getLetterCount normalizedCandidate
    normalizedCandidate != normalizedSubject && subjectLetterCount == candidateLetterCount
  )

end Anagram
