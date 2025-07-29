export const toRna = (dna) => {
  return dna.replaceAll(/[ACGT]/g, match => {
    switch (match.toUpperCase()) {
      case "G": return "C";
      case "C": return "G";
      case "T": return "A";
      case "A": return "U";
      default: return "";
    }
  });
};
