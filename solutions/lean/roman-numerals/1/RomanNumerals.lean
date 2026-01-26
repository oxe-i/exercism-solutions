namespace RomanNumerals

def table : Array ({ x : Nat // 0 < x } × String) := #[
    (⟨1000, by decide⟩, "M"), (⟨900, by decide⟩, "CM"), (⟨500, by decide⟩, "D"),
    (⟨400, by decide⟩, "CD"), (⟨100, by decide⟩, "C"), (⟨90, by decide⟩, "XC"),
    (⟨50, by decide⟩, "L"), (⟨40, by decide⟩, "XL"), (⟨10, by decide⟩, "X"),
    (⟨9, by decide⟩, "IX"), (⟨5, by decide⟩, "V"), (⟨4, by decide⟩, "IV"),
    (⟨1, by decide⟩, "I")
  ]

def roman (number : Fin 4000) : String :=
  let rec helper (n : Nat) : String :=
    if n = 0 then ""
    else
      match table.find? (λ (x, _) => n >= x) with
      | none        => ""
      | some (v, s) => s ++ helper (n - v)
  helper number.val

end RomanNumerals
