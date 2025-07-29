function isOdd(x) { return x % 2; }
function doubleDigit(x) { return x >= 5 ? 2 * x - 9 : 2 * x; }

export const valid = (string) => {
  if (/[^\s\d]/.test(string)) return false;
  const digits = [...string.matchAll(/\d/g)];
  const length = digits.length;
  return length > 1 && digits.reduce((acc, digStr, idx) => {
    const digit = parseInt(digStr[0]);
    return acc + (isOdd(length - idx) ? digit : doubleDigit(digit));
  }, 0) % 10 == 0;
};
