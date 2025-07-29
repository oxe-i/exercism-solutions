export const largestProduct = (str, len) => {
  if (len < 0) throw new Error("span must not be negative");
  if (len > str.length) throw new Error("span must not exceed string length");
  const digits = [...str].map((digit) => {
    if (!/\d/.test(digit)) throw new Error("digits input must only contain digits");
    return Number(digit);
  });
  return digits
    .map((_, idx) => digits.slice(idx, idx + len))
    .reduce((max, span) => {
      if (span.length !== len) return max;
      const prod = span.reduce((acc, num) => acc * num);
      return prod > max ? prod : max;
    }, 0);
};
