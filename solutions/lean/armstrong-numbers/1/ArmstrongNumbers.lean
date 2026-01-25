namespace ArmstrongNumbers

def getDigits (number : Nat) (acc : List (Fin 10)) : List (Fin 10) :=
  if isDigit : number < 10 then ⟨number, isDigit⟩ :: acc
  else
    let digit := number % 10
    let rest := number / 10
    getDigits rest (⟨digit, by grind⟩ :: acc)

def isArmstrongNumber (number : Nat) : Bool :=
  let digits := getDigits number []
  let numDigits := digits.length
  number == digits.foldl (λ sum ⟨digit, _⟩ => sum + digit ^ numDigits) 0

end ArmstrongNumbers
