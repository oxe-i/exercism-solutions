export const parse = (text) => {
  return [...text.matchAll(/((?<=[\s-]+[^A-Za-z]?)[A-Za-z]|^[A-Za-z])/g)]
    .reduce((acc, match) => acc + match[0].toUpperCase(), "");
};
