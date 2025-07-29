/**
  * param {string[]} lines
  * @returns {string[]}
  */
export const transpose = (lines) => {
  const maxLength = lines.reduce((acc, line) => Math.max(line.length, acc), 0);
  lines.forEach(line => line.padEnd(maxLength - line.length));
  return lines
    .reduce((transposed, line, row) => {
      console.log(transposed);
      [...line].forEach((letter, col) => transposed[col][row] = letter);
      return transposed;
    }, Array.from({length: maxLength}, (_) => Array.from({length: lines.length}, (_) => "")))
    .map(transposedLine => {
      const lastLetter = transposedLine.findLastIndex(value => value !== "");
      for (let i = 0; i < lastLetter; ++i) {
        transposedLine[i] = transposedLine[i] || " ";
      }
      return transposedLine.join("");
    });
};
