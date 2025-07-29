export const clean = (string) => {
  const digits = [];
  for (const val of string) {
    if (/[a-z]/i.test(val)) throw new Error("Letters not permitted");
    if (/[^\d ().+-]/.test(val)) throw new Error("Punctuations not permitted");
    if (/\d/.test(val)) digits.push(val);
  }
  const len = digits.length;
  if (len < 10) throw new Error("Must not be fewer than 10 digits");
  if (len > 11) throw new Error("Must not be greater than 11 digits");
  if (len == 11 && digits[0] != "1") throw new Error("11 digits must start with 1");
  const minusCountryCode = digits.slice(-10);
  const areaCode = minusCountryCode.slice(0, 3);
  const exchangeCode = minusCountryCode.slice(3);
  if (areaCode[0] == "0") throw new Error("Area code cannot start with zero");
  if (areaCode[0] == "1") throw new Error("Area code cannot start with one");
  if (exchangeCode[0] == "0") throw new Error("Exchange code cannot start with zero");
  if (exchangeCode[0] == "1") throw new Error("Exchange code cannot start with one");
  return minusCountryCode.join("");
};
