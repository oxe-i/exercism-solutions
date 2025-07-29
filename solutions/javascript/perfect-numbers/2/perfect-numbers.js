function getDivisorsSum(number) {
  const divisors = new Set((number == 1 ? [] : [1]));
  const root = Math.floor(Math.sqrt(number));
  for (let i = 2; i <= root; ++i) {
    if (number % i == 0) {
      divisors.add(i);
      divisors.add(number / i);
    }
  }
  return [...divisors].reduce((acc, divisor) => acc + divisor, 0);
}

export const classify = (number) => {
  if (number <= 0) throw new Error("Classification is only possible for natural numbers.");
  const sumOfDivisors = getDivisorsSum(number);
  if (sumOfDivisors > number) return "abundant";
  if (sumOfDivisors < number) return "deficient";
  return "perfect";
};
