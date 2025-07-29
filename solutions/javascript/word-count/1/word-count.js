export const countWords = (text) => {
  return text
    .split(/[^\w']|(?<=[^\w])'|'(?=[^\w])|^'|'$/)
    .reduce((acc, word) => {
      if (!word) return acc;
      word = word.toLowerCase();
      acc[word] = 1 + (acc[word] ?? 0);
      return acc;
    }, {});
};