export class Squares {
  #squareOfSum;
  #sumOfSquares;
 
  constructor(n) {
    this.#squareOfSum = 0;
    this.#sumOfSquares = 0;
    for (let i = 1; i <= n; ++i) {
      this.#sumOfSquares += (i ** 2);
      this.#squareOfSum += i;
    } 
    this.#squareOfSum *= this.#squareOfSum;
  }

  get sumOfSquares() {
    return this.#sumOfSquares;
  }

  get squareOfSum() {
    return this.#squareOfSum;
  }

  get difference() {
    return this.#squareOfSum - this.#sumOfSquares;
  }
}
