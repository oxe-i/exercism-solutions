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

  reset() {
    do {
      this.#name = this.#letter + this.#letter + this.#digit + this.#digit + this.#digit;
    } while (Robot.#nameSet.has(this.#name));
    Robot.#nameSet.add(this.#name);
  }

  get name() {
    return this.#name.slice(0);
  }

  static releaseNames() {
    Robot.#nameSet.clear();
  }
}
