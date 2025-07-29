export class ResistorColorTrio {
  #value;
  #unit;

  static #colorMap = {
    black: 0,
    brown: 1,
    red: 2,
    orange: 3,
    yellow: 4,
    green: 5,
    blue: 6,
    violet: 7,
    grey: 8,
    white: 9,
  };

  constructor(colors) {
    const [digit1, digit2, exp] = colors.map((color) => {
      const value = ResistorColorTrio.#colorMap?.[color];
      if (value === undefined) throw new Error("invalid color");
      return value;
    });
    const result = (digit1 * 10 + digit2) * (10 ** exp);
    this.#value = result >= 1000 ? result / 1000 : result;
    this.#unit = `${result >= 1000 ? "kilo" : ""}ohms`;
  }

  get label() {
    return `Resistor value: ${this.#value} ${this.#unit}`;
  }
}
