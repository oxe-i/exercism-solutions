namespace Leap

def leapYear (year : UInt16) : Bool :=
  let divisibleBy25 := year % 25 == 0
  let divisibleBy4 := year &&& 3 == 0
  let divisibleBy16 := year &&& 15 == 0
  (divisibleBy16 && divisibleBy25) || (divisibleBy4 && !divisibleBy25)

end Leap
