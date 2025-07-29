class Nucleotide {
  static A = 0;
  static C = 1;
  static G = 2;
  static T = 3;
}

export function countNucleotides(strand) {
  return strand
    .split("")
    .reduce((acc, nucleotide) => {
      switch (nucleotide) {
        case "A": acc[Nucleotide.A]++; return acc;
        case "C": acc[Nucleotide.C]++; return acc;
        case "G": acc[Nucleotide.G]++; return acc;
        case "T": acc[Nucleotide.T]++; return acc;
        default: throw new Error("Invalid nucleotide in strand");
      }
    }, new Array(4).fill(0))
    .join(" ");
}
