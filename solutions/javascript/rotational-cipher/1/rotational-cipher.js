const rotLetter = (num) => (letter) => {
  if (/[a-z]/.test(letter)) {
    const code = letter.charCodeAt(0);
    const a = "a".charCodeAt(0);
    return String.fromCharCode(a + ((code - a + num) % 26));
  }
  if (/[A-Z]/.test(letter)) {
    const code = letter.charCodeAt(0);
    const A = "A".charCodeAt(0);
    return String.fromCharCode(A + ((code - A + num) % 26));
  }
  return letter;
}

export const rotate = (string, num) => {
  return string.replaceAll(/./g, rotLetter(num));
};
