//
// This is only a SKELETON file for the 'Nth Prime' exercise. It's been provided as a
// convenience to get you started writing code faster.
//

function* numList() {
  for (let num = 2; ; num++)
    yield num;
}

function* filter(fns, list) {
  for (const elem of list) {
    if (fns.some(fn => !fn(elem))) continue;
    yield elem;
  }
}

export const prime = (n) => {
  if (n == 0) throw "there is no zeroth prime";
  const comp = [];
  const list = numList();
  for (let i = 1; i < n; ++i) {
    comp.push(((prime) => (num) => {
      return num < (prime ** 2) || num % prime;
    })(filter(comp, list).next().value));
  }
  return filter(comp, list).next().value;
};
