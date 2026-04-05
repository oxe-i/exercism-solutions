namespace PalindromeProducts

structure Factors where
  a : Nat
  b : Nat
  h : a ≤ b
  deriving BEq, Repr

structure Result where
  product : Nat
  factors : List Factors
  deriving BEq, Repr

private def isPalindromic (n : Nat) : Bool :=
  let digits := Nat.toDigits 10 n
  digits == digits.reverse

private def process (min max : Nat) (comp : Nat → Result → Bool) : Option Result := do
  let mut res : Option Result := none
  for b in [min : max + 1] do
    for d in [0 : b - min + 1] do
      let a := b - d
      have h: a ≤ b := by omega
      let p := a * b
      if res.any (comp p)
      then break
      if isPalindromic p then
        res := res.map (fun ⟨p₂, f⟩ =>
          if p == p₂
          then ⟨p, { a, b, h } :: f⟩
          else ⟨p, [{ a, b, h }]⟩
        ) <|> some ⟨p, [{ a, b, h }]⟩
  res
    
def smallest (min max : Nat) (_ : min ≤ max) : Option Result :=  
  process min max fun p { product, .. } => p > product
  
def largest (min max : Nat) (_ : min ≤ max) : Option Result := 
  process min max fun p { product, .. } => p < product

end PalindromeProducts
