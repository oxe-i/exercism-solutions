export class Robot {
  #name;
  static #nameSet = new Set();

  constructor() {
    this.reset();
  }

  #randomChar(min, max) {
    const minCode = min.charCodeAt(0);
    const maxCode = max.charCodeAt(0);
    const randomCode = minCode + Math.random() * (1 + maxCode - minCode);
    return String.fromCharCode(randomCode);
  }

  get #digit() {
    return this.#randomChar("0", "9");
  }

  get #letter() {
    return this.#randomChar("A", "Z");
  }

  #generateName() {
    const alpha = `${this.#letter}${this.#letter}`;
    const num = `${this.#digit}${this.#digit}${this.#digit}`;
    this.#name = alpha + num;
  }

  reset() {
    do this.#generateName();
    while (Robot.#nameSet.has(this.#name));
    Robot.#nameSet.add(this.#name);
  }

  get name() {
    return this.#name.slice(0);
  }

  static releaseNames() {
    Robot.#nameSet.clear();
  }
}
