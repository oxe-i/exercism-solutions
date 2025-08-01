//
// This is only a SKELETON file for the 'Pangram' exercise. It's been provided as a
// convenience to get you started writing code faster.
//

export const isPangram = (sentence) => {
  const letters = sentence.replaceAll(/[^a-z]/g, (char) => {
    return /[A-Z]/.test(char) ? char.toLowerCase() : "";
  })
  return new Set(letters).size == 26;
}
