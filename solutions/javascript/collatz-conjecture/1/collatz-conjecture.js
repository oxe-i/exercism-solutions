function isEven(n) { return n % 2 === 0; }

function helper(n, acc) {
  if (n === 1) return acc;
  return isEven(n) ? helper(n / 2, acc + 1) : helper(3 * n + 1, acc + 1);
}

export const steps = (n) => {
  if (n <= 0) throw new Error("Only positive integers are allowed");
  return helper(n, 0);
};
