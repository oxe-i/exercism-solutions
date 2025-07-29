function rotate(letter) {
  if (!/[\w]/.test(letter)) return "";
  if (/[\d]/.test(letter)) return letter;
  letter = letter.toLowerCase();
  const code = letter.charCodeAt(0);
  const [a, z] = [
    "a".charCodeAt(0), 
    "z".charCodeAt(0)
  ];
  return String.fromCharCode(a + (z - code));
}

function chunkN(str, n) {
  if (!str.length) return [];
  return [
    str.slice(0, n), 
    ...chunkN(str.slice(n), n)
  ];
}

export const encode = (str) => {
  const rotated = str.replaceAll(/./g, rotate);
  const chunks = chunkN(rotated, 5);
  return chunks.join(" ");
};

export const decode = (str) => {
  const rotated = str.replaceAll(/./g, rotate);
  return rotated;
};
