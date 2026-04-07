namespace NucleotideCount

inductive Nucleotide where
  | A | C | G | T

structure Counts where
  counts : Vector Nat 4
  deriving Repr

instance : GetElem Counts Nucleotide Nat (fun _ _ => True) where
  getElem
    | { counts }, .A, _ => counts[0]
    | { counts }, .C, _ => counts[1]
    | { counts }, .G, _ => counts[2]
    | { counts }, .T, _ => counts[3]

private def inc (vec : Vector Nat 4) (i : Fin 4) : Vector Nat 4 :=
  vec.set i (vec[i] + 1)

def nucleotideCounts (strand : String) : Option Counts :=
  strand.toSlice.chars.foldM (init := { counts := Vector.replicate 4 0 }) fun
    | { counts }, 'A' => some { counts := inc counts 0 }
    | { counts }, 'C' => some { counts := inc counts 1 }
    | { counts }, 'G' => some { counts := inc counts 2 }
    | { counts }, 'T' => some { counts := inc counts 3 }
    | _, _ => none

end NucleotideCount
