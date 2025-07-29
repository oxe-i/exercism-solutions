
export function triplets({ minFactor, maxFactor, sum }) {
  minFactor = minFactor ?? 1;
  maxFactor = maxFactor ? Math.min(maxFactor, sum - minFactor - 1) : sum - minFactor - 1;

  const tripletsArray = [];
  for (let c = maxFactor; c >= minFactor; --c) {
    const diff = sum - c;
    const maxA = diff >> 1;
    for (let a = minFactor; a <= maxA; ++a) {
      const b = diff - a;
      if (a*a + b*b === c*c) {
        tripletsArray.push(new Triplet(a, b, c));
      }
    }
  }
  return tripletsArray;
}

class Triplet {
  #triplets;

  constructor(a, b, c) {
    this.#triplets = [a, b, c];
  }

  toArray() {
    return [...this.#triplets];
  }
}
