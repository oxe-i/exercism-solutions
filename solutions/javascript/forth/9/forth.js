export class Forth {
  #patterns;
  #stack;

  static #END = "#END";

  #throwUnary = (callback) => (x) => {
    if (x === undefined) throw new Error("Stack empty");
    return callback(x);
  };

  #throwBinary = (callback) =>
    this.#throwUnary((y) => (z) => {
      if (z === undefined) throw new Error("Only one value on the stack");
      return callback(y, z);
    });

  #consumeOperation = (expression) => {
    for (const [pattern, callback] of this.#patterns) {
      const match = expression.match(pattern);
      if (match) return { match: match, callback: callback };
    }
    throw new Error("Unknown command");
  };

  constructor() {
    this.#patterns = [
      [/^dup/i, () => this.#throwUnary((x) => [x, x])],
      [/^over/i, () => this.#throwBinary((x, y) => [y, x, y])],
      [/^drop/i, () => this.#throwUnary(() => [])],
      [/^swap/i, () => this.#throwBinary((x, y) => [x, y])],
      [/^-?\d+/i, (x) => Number(x)],
      [/^\+/i, () => this.#throwBinary((x, y) => y + x)], 
      [/^-/i, () => this.#throwBinary((x, y) => y - x)],
      [/^\*/i, () => this.#throwBinary((x, y) => y * x)],
      [
        /^\//i,
        () =>
          this.#throwBinary((x, y) => {
            if (x === 0) throw new Error("Division by zero");
            return (y / x) | 0;
          }),
      ],
      [
        /:\s(.*?)\s(.*)\s;/i,
        (x) => {
          const groups = x.match(/:\s(.*?)\s(.*)\s;/i);
          if (/^\s*-?\d+\s*$/.test(groups[1]))
            throw new Error("Invalid definition");
          const key = new RegExp(`^${RegExp.escape(groups[1])}`, "i");
          const subs = groups[2].split(" ").map((opName) => {
            return this.#consumeOperation(opName).callback(opName);
          });
          const crtFN = this.#patterns.indexOf(key);
          if (crtFN !== -1) this.#patterns.splice(crtFN, 1);
          this.#patterns.unshift([key, () => subs]);
          return [];
        },
      ],
    ];
    this.#stack = [];
  }

  evaluate(expressions) {
    while (expressions.length) {
      expressions = expressions.trimStart();
      const { match, callback } = this.#consumeOperation(expressions);
      expressions = expressions.slice(match[0].length);
      const fns = [callback(match[0])].flat(Infinity);
      this.#stack = fns.reduce((acc, fn) => {
        while (typeof fn === "function") fn = fn(acc.pop());
        acc.push(fn);
        return acc.flat(Infinity);
      }, this.#stack);
    }
  }

  get stack() {
    return [...this.#stack];
  }
}