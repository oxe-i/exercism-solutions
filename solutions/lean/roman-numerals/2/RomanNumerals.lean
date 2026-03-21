namespace RomanNumerals

private def table : Array ({ x : Fin 4000 // 0 < x } × String) := #[
  (⟨1000, by decide⟩, "M"), (⟨900, by decide⟩, "CM"), (⟨500, by decide⟩, "D"),
  (⟨400, by decide⟩, "CD"), (⟨100, by decide⟩, "C"), (⟨90, by decide⟩, "XC"),
  (⟨50, by decide⟩, "L"), (⟨40, by decide⟩, "XL"), (⟨10, by decide⟩, "X"),
  (⟨9, by decide⟩, "IX"), (⟨5, by decide⟩, "V"), (⟨4, by decide⟩, "IV"),
  (⟨1, by decide⟩, "I")
]

private def go (acc : String) : Fin 4000 → String
  | 0 => acc
  | n =>
    match h₀: table.find? (n ≥ ·.fst) with
    | none        => acc
    | some (v, s) => go (acc ++ s) (n - v)
termination_by n => n.val
decreasing_by -- grind would work automatically here
  have h₁: v.val ≤ n := by
    simpa [h₀] using Array.find?_some h₀
  simpa [Fin.sub_val_of_le h₁]
  using Nat.sub_lt_self v.property h₁

def roman : Fin 4000 → String := go ""

end RomanNumerals
