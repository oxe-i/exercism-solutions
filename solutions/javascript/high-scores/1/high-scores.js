export class HighScores {
  #input;
  
  constructor(input) {
    this.#input = [...input];
  }

  get scores() {
    return this.#input.map(value => value);
  }

  get latest() {
    return this.#input.at(-1);
  }

  get personalBest() {
    return this.#input.reduce((acc, val) => val > acc ? val : acc);
  }

  get personalTopThree() {
    return this.#input.reduce((acc, val) => {
      if (acc.length < 3) {
        acc.push(val);
      }
      else {
        const lower = acc.findIndex(best => best < val);
        if (lower != -1) acc.splice(lower, 1, val);
      }
      return acc;
    }, []).sort((a, b) => b - a);
  }
}
