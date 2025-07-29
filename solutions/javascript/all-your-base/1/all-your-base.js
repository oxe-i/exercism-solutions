export const convert = (numArr, from, to) => {
  if (from < 2) throw new Error("Wrong input base");
  if (to < 2) throw new Error("Wrong output base");

  const len = numArr.length;
  if (len === 1 && numArr[0] === 0) return [0];
  if (!len || !numArr[0]) throw new Error("Input has wrong format");

  let num10 = 0;
  while (numArr.length) {
    const exp = len - numArr.length;
    const fromDigit = numArr.pop();
    if (fromDigit < 0 || fromDigit >= from) throw new Error("Input has wrong format");
    num10 += fromDigit * from ** exp;
  }

  while (num10) {
    const toDigit = num10 % to;
    num10 = (num10 - toDigit) / to;
    numArr.unshift(toDigit);
  }
  return numArr;
};
