export const primes = (top) => {
  let candidates = [];
  for (let i = 2; i <= top; ++i)
    candidates.push(i);
  const primeList = [];
  while (candidates.length) {
    const prime = candidates.shift();
    primeList.push(prime);
    const square = prime ** 2;
    candidates = candidates.filter(val => {
      return val < square || val % prime;
    });
  }
  return primeList;
};
