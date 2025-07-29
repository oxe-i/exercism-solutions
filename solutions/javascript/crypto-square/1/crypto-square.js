export class Crypto {
  #text;

  #dimensions(len) {
    let rows = Math.floor(Math.sqrt(len));
    let cols = Math.ceil(len / rows);
    if (cols - rows > 1) return [rows + 1, cols - 1];
    return [rows, cols];
  }

  #recurSplit(str, n) {
    if (!str.length || !n) return [];
    return [str.slice(0, n), ...this.#recurSplit(str.slice(n), n)];
  }
  
  constructor(text) {
    const normalizedTxt = text.replaceAll(/./g, (letter) => {
      if (/[\s\p{P}]/u.test(letter)) return "";
      return letter.toLowerCase();
    });
    
    const [rows, cols] = this.#dimensions(normalizedTxt.length);
    const rectangle = this.#recurSplit(normalizedTxt, cols);
    
    if (!rectangle.length) {
      this.#text = "";
      return;
    }
    
    rectangle[rows - 1] = rectangle[rows - 1].padEnd(cols);
    const encoded = Array.from({ length: cols }, (_, rIdx) => {
      return Array.from({ length: rows }, (_, cIdx) => {
        return rectangle[cIdx][rIdx];
      });
    });    
    this.#text = encoded.map(row => row.join("")).join(" ");
  }

  get ciphertext() {
    return this.#text.slice(0);
  }
}
