namespace Leap
   
def leapYear (year : UInt16) : Bool :=
  let y := year.toNat
  (400 ∣ y) ∨ 
  ((4 ∣ y) ∧ ¬ (100 ∣ y))

end Leap
