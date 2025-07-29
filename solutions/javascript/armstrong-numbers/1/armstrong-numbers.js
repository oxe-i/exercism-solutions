export const isArmstrongNumber = (number) => {
  const parsingFN = typeof number == "bigint" ? BigInt : Number;
  const digits = [...String(number)].map(parsingFN);
  const power = parsingFN(digits.length);
  return number == digits.map(digit => (digit ** power)).reduce((acc, val) => acc + val);
};
