namespace Hamming

def distance (strand1 : String) (strand2 : String) : Option Nat := do
  guard (strand1.length == strand2.length)
  let mut diff := 0
  let mut s1 := strand1.startValidPos
  let mut s2 := strand2.startValidPos
  while h: s1 ≠ strand1.endValidPos ∧ s2 ≠ strand2.endValidPos do
    let c1 := s1.get h.left
    let c2 := s2.get h.right
    if c1 ≠ c2 then diff := diff + 1
    s1 := s1.next!
    s2 := s2.next!
  return diff

end Hamming
