export const largestProduct = (digitString, spanLength) => {
  if (spanLength < 0) throw new Error("span must not be negative");
  if (spanLength > digitString.length) throw new Error("span must not exceed string length");
  const digits = [...digitString].map((digit) => {
    if (!/\d/.test(digit)) throw new Error("digits input must only contain digits");
    return Number(digit);
  });
  const spans = digits
    .map((_, idx) => digits.slice(idx, idx + spanLength))
    .filter((span) => span.length === spanLength);
  return spans.reduce((max, span) => {
    return Math.max(max, span.reduce((prod, digit) => prod * digit));
  }, 0);
};
