//infinite list of all integers starting from 2
function* numList() {
  yield 2;
  for (let num = 3; ; num += 2) yield num;
}

/**
 * list of all elements of a list which satisfy a series of conditions
 * @param {((elem: unknown) => boolean)[]} fns 
 * @param {Generator<unknown, void, unknown>} list 
 */
function* filter(fns, list) {
  for (const elem of list) {
    if (fns.every(fn => fn(elem))) yield elem;
  }
}

/**
 * computes the nth-prime
 * @param {number} n 
 * @returns {number}
 */
export const prime = (n) => {
  if (n == 0) throw new Error("there is no zeroth prime");
  const compositeChecks = [];
  const list = numList();
  for (let i = 1; i < n; ++i) {
    compositeChecks.push(((prime) => (num) => {
      return num < (prime ** 2) || num % prime;
    })(filter(compositeChecks, list).next().value));
  }
  return filter(compositeChecks, list).next().value;
};
