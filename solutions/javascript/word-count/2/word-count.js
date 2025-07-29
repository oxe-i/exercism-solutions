export const countWords = (text) => {
  return text
    .match(/\w+('\w+)?/g)
    .reduce((acc, word) => {     
      word = word.toLowerCase();
      acc[word] = 1 + (acc[word] ?? 0);
      return acc;
    }, {});
};