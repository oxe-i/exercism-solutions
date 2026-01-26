namespace ProteinTranslation

inductive Protein where
  | Methionine : Protein
  | Phenylalanine : Protein
  | Leucine : Protein
  | Serine : Protein
  | Tyrosine : Protein
  | Cysteine : Protein
  | Tryptophan : Protein
  deriving BEq, Repr

def translate : String -> Except String Protein
  | "AUG"                         => .ok .Methionine
  | "UUU" | "UUC"                 => .ok .Phenylalanine
  | "UUA" | "UUG"                 => .ok .Leucine
  | "UCU" | "UCC" | "UCA" | "UCG" => .ok .Serine
  | "UAU" | "UAC"                 => .ok .Tyrosine
  | "UGU" | "UGC"                 => .ok .Cysteine
  | "UGG"                         => .ok .Tryptophan
  | _                             => .error "Invalid codon"

def processCodons : List Char -> Array Protein -> Except String (Array Protein)
  | [], acc                     => .ok acc
  | [_], _
  | [_, _], _                   => .error "Invalid codon"
  | 'U' :: 'A' :: 'A' :: _, acc
  | 'U' :: 'A' :: 'G' :: _, acc
  | 'U' :: 'G' :: 'A' :: _, acc => .ok acc
  | c1 :: c2 :: c3 :: cs, acc   => do
    let codon ← translate [c1, c2, c3].asString
    processCodons cs (acc.push codon)

def proteins (strand : String) : Except String (Array Protein) :=
  processCodons strand.toList #[]

end ProteinTranslation
