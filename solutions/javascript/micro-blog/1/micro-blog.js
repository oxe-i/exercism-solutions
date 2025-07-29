export const truncate = (input) => {
  return [...input.matchAll(/./gu)].slice(0, 5).reduce((acc, match) => acc + match[0], "");
};
