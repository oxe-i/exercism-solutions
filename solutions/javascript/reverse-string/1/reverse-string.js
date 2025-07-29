export const reverseString = (str) => {
  const helper = (acc, ix) => str.length === ix ? acc : helper(str[ix] + acc, ix + 1);
  return helper("", 0);
};
