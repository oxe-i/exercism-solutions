export const encode = (str) => {
  return str.replaceAll(/(.)\1+/g, (match, ch) => `${match.length}${ch}`);
};

export const decode = (str) => {
  return str.replaceAll(/(\d+)(.)/g, (_, n, ch) => ch.padStart(Number(n), ch));
};
