export const isIsogram = (text) => {
  const letters = new Set();
  for (const letter of text) {
    const lowered = letter.toLowerCase();
    if (letters.has(lowered)) return false;
    if (/[a-z]/.test(lowered)) letters.add(lowered);
  }
  return true;
};
