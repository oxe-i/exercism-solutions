export const isValid = (isbn) => {
  const matches = isbn.match(
    /^(\d)-?(\d)(\d)(\d)-?(\d)(\d)(\d)(\d)(\d)-?(\d|X)$/
  );
  if (!matches) return false;
  const digits = matches.slice(1);
  const sum = digits.reduce((acc, digit, idx) => {
    const multiplier = digits.length - idx;
    return acc + multiplier * (/\d/.test(digit) ? parseInt(digit) : 10);
  }, 0);
  return sum % 11 == 0;
};
