namespace NucleotideCount

inductive Nucleotide where
  | A | C | G | T

def Counts := Vector Nat 4 deriving Repr

instance : GetElem Counts Nucleotide Nat (fun _ _ => True) where
  getElem
    | ⟨counts, h⟩, .A, _ => counts[0]
    | ⟨counts, h⟩, .C, _ => counts[1]
    | ⟨counts, h⟩, .G, _ => counts[2]
    | ⟨counts, h⟩, .T, _ => counts[3]

def nucleotideCounts (strand : String) : Option Counts :=
  strand.toSlice.chars.foldM (init := Vector.replicate 4 0) fun
    | ⟨counts, h⟩, 'A' => some ⟨counts.modify 0 (· + 1), by simp [h, counts.size_modify]⟩
    | ⟨counts, h⟩, 'C' => some ⟨counts.modify 1 (· + 1), by simp [h, counts.size_modify]⟩
    | ⟨counts, h⟩, 'G' => some ⟨counts.modify 2 (· + 1), by simp [h, counts.size_modify]⟩
    | ⟨counts, h⟩, 'T' => some ⟨counts.modify 3 (· + 1), by simp [h, counts.size_modify]⟩
    | _, _ => none

end NucleotideCount
