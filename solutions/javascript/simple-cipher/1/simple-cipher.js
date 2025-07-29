//
// This is only a SKELETON file for the 'Simple Cipher' exercise. It's been provided as a
// convenience to get you started writing code faster.
//

export class Cipher {
  #keys;

  static get #minCode() {
    return "a".charCodeAt(0);
  }

  static get #maxCode() {
    return "z".charCodeAt(0);
  }

  static get #codeRange() {
    return 1 + this.#maxCode - this.#minCode;
  }

  #clampCode(code) {
    const modDist = (dist) => dist % Cipher.#codeRange;
    const clampDist = (dist) => modDist(modDist(dist) + Cipher.#codeRange);
    return Cipher.#minCode + clampDist(code - Cipher.#minCode);
  }

  #extractKeys(keyStr) {
    return [...keyStr].reduce((acc, letter) => {
      const code = letter.toLowerCase().charCodeAt(0);
      if (code >= Cipher.#minCode && code <= Cipher.#maxCode)
        acc.push(code - Cipher.#minCode);
      return acc;
    }, []);
  }

  get #randomCode() {
    return Math.floor(Math.random() * Cipher.#codeRange);
  }

  #randomkeys() {
    return Array.from({ length: 100 }, () => {
      return this.#randomCode;
    });
  }

  constructor(keyStr) {
    if (typeof keyStr === "string" || keyStr instanceof String) {
      this.#keys = this.#extractKeys(keyStr);
    } else {
      this.#keys = this.#randomkeys();
    }
  }

  #adjustText(text, fn) {
    if (!this.#keys.length) return text;
    return [...text]
      .map((letter, idx) => {
        const keyIdx = idx % this.#keys.length;
        const crtCode = letter.charCodeAt(0);
        return String.fromCharCode(fn(crtCode, this.#keys[keyIdx]));
      })
      .join("");
  }

  encode(text) {
    return this.#adjustText(text, (a, b) => this.#clampCode(a + b));
  }

  decode(text) {
    return this.#adjustText(text, (a, b) => this.#clampCode(a - b));
  }

  get key() {
    return this.#keys
      .map((diff) => String.fromCharCode(Cipher.#minCode + diff))
      .join("");
  }
}
