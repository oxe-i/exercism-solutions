export const rows = (letter) => {
  const startCode = "A".charCodeAt(0);
  const dist = letter.charCodeAt(0) - startCode;
  const topRightquarter = Array.from({ length: dist + 1 }, (_, i) => {
    return " ".repeat(i) + String.fromCharCode(startCode + i) + " ".repeat(dist - i);
  });
  const topHalf = topRightquarter.map((row) => {
    return [...row.slice(1)].reverse().join("").concat(row);
  });
  return topHalf.concat(topHalf.slice(0, -1).reverse());
};
