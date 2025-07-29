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
      if (match) return { match: match, fn: callback };
    }
    throw new Error("Unknown command");
  };

  static #stream(...values) {
    if (values.length === 0) return (gn) => Forth.#stream(gn);
    if (values[0] === Forth.#END) return values.slice(1);

    let fn = values.shift();
    while (typeof fn === "function") fn = fn(values.shift());
    return (gn) => Forth.#stream(gn, ...[fn, values].flat(Infinity));
  }

  constructor() {
    this.#patterns = [
      [/^dup/i, () => this.#throwUnary((x) => [x, x])],
      [/^over/i, () => this.#throwBinary((x, y) => [y, x, y])],
      [/^drop/i, () => this.#throwUnary(() => [])],
      [/^swap/i, () => this.#throwBinary((x, y) => [y, x])],
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
            return this.#consumeOperation(opName).fn(opName);
          });
          const crtFN = this.#patterns.indexOf(key);
          if (crtFN !== -1) this.#patterns.splice(crtFN, 1);
          this.#patterns.unshift([key, () => subs.reverse()]);
          return [];
        },
      ],
    ];
    this.#stack = [];
  }

  evaluate(expressions) {
    let stream = Forth.#stream;
    while (expressions.length) {
      expressions = expressions.trimStart();
      const { match, fn } = this.#consumeOperation(expressions);
      expressions = expressions.slice(match[0].length);
      stream = stream(fn(match[0]));
    }

    const endStream = [...stream(Forth.#END)].reverse();
    this.#stack = endStream.reduce((acc, exp) => {
      while (typeof exp === "function" && acc.length) exp = exp(acc.pop());
      acc.push(exp);
      return acc.flat(Infinity);
    }, []);
  }

  get stack() {
    return [...this.#stack];
  }
}
