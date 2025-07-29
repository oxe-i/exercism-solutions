export const primeFactors = (num) => {
  if (num === 1) return [];
  for (let factor = 2; factor * factor <= num; factor++)
    if (num % factor === 0) return [factor, ...primeFactors(num / factor)];
  return [num];
};
