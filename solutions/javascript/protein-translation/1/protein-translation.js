function toAminoacid(codon) {
  const map = new Map([
    ["AUG", "Methionine"],
    ...["UUU", "UUC"].map(c => [c, "Phenylalanine"]),
    ...["UUA", "UUG"].map(c => [c, "Leucine"]),
    ...["UCU", "UCC", "UCA", "UCG"].map(c => [c, "Serine"]),
    ...["UAU", "UAC"].map(c => [c, "Tyrosine"]),
    ...["UGU", "UGC"].map(c => [c, "Cysteine"]),
    ["UGG", "Tryptophan"],
    ...["UAA", "UAG", "UGA"].map(c => [c, "STOP"])
  ]);
  return map.get(codon);
}

export const translate = (rna) => {
  if (!rna) return [];
  const aminoacids = [];
  for (let i = 0; i < rna.length; i += 3) {
    const aminoacid = toAminoacid(rna.slice(i, i + 3));
    if (aminoacid === "STOP") return aminoacids;
    if (!aminoacid) throw new Error("Invalid codon");
    aminoacids.push(aminoacid);
  }
  return aminoacids;
};
