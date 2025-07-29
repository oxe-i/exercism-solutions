//
// This is only a SKELETON file for the 'Hamming' exercise. It's been provided as a
// convenience to get you started writing code faster.
//

export class UnequalLengthStrands extends Error {
  constructor() {
    super("strands must be of equal length");
  }
}

export const compute = (strand1, strand2) => {
  if (strand1.length != strand2.length) 
    throw new UnequalLengthStrands;
  return [...strand1].reduce((acc, nucleotide, idx) => {
    return acc + (nucleotide != strand2[idx]);
  }, 0);
}