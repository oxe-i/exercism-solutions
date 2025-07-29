export class ResistorColorTrio {
  #value;

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

  static #prefixes = [
    [1000000000, "giga"],
    [1000000, "mega"],
    [1000, "kilo"],
    [0, ""]
  ];

  constructor(colors) {
    const [digit1, digit2, exp] = colors.map((color) => {
      const value = ResistorColorTrio.#colorMap?.[color];
      if (value === undefined) throw new Error("invalid color");
      return value;
    });
    const result = (digit1 * 10 + digit2) * (10 ** exp);
    const prefix = ResistorColorTrio.#prefixes.find(([factor,]) => {
      return result >= factor;
    });
    
    this.#value = `${result / (prefix[0] || 1)} ${prefix[1]}ohms`;
  }

  get label() {
    return `Resistor value: ${this.#value}`;
  }
}
