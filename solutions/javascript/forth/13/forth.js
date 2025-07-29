export class Forth {
  #patterns;
  #stack;

  #unary = (callback) => (x) => {
    if (x === undefined) throw new Error("Stack empty");
    return callback(x);
  };

  #binary = (callback) => {
    return this.#unary((y) => (z) => {
      if (z === undefined) throw new Error("Only one value on the stack");
      return callback(y, z);
    });
  };

  #consumeOperation = (expression) => {
    for (const [pattern, callback] of this.#patterns) {
      const match = expression.match(pattern);
      if (match) return { pattern: match[0], callback: callback };
    }
    throw new Error("Unknown command");
  };

  #processUserOps = (pattern) => {
    const groups = pattern.match(/:\s(.*?)\s(.*)\s;\s?/i);
    if (/^\s*-?\d+\s*$/.test(groups[1])) throw new Error("Invalid definition");
    const key = new RegExp(`^\\s?${RegExp.escape(groups[1])}`, "i");
    const ops = groups[2].split(" ").map((opName) => {
      return this.#consumeOperation(opName).callback(opName);
    });
    return { key: key, ops: ops };
  };

  constructor() {
    this.#patterns = [
      [/^\s?dup\s?/i, () => this.#unary((x) => [x, x])],
      [/^\s?over\s?/i, () => this.#binary((x, y) => [y, x, y])],
      [/^\s?drop\s?/i, () => this.#unary(() => [])],
      [/^\s?swap\s?/i, () => this.#binary((x, y) => [x, y])],
      [/^\s?-?\d+\s?/i, (x) => Number(x)],
      [/^\s?\+\s?/i, () => this.#binary((x, y) => y + x)],
      [/^\s?-\s?/i, () => this.#binary((x, y) => y - x)],
      [/^\s?\*\s?/i, () => this.#binary((x, y) => y * x)],
      [
        /^\s?\/\s?/i,
        () => {
          return this.#binary((x, y) => {
            if (x === 0) throw new Error("Division by zero");
            return (y / x) | 0;
          });
        },
      ],
      [
        /\s?:\s(.*?)\s(.*)\s;\s?/i,
        (expression) => {
          const { key, ops } = this.#processUserOps(expression);
          const crtIDX = this.#patterns.findIndex((crt) => crt.source === key.source);
          if (crtIDX !== -1) this.#patterns.splice(crtIDX, 1, [key, () => ops]);
          else this.#patterns.unshift([key, () => ops]);
          return [];
        },
      ],
    ];
    this.#stack = [];
  }

  evaluate(expressions) {
    this.#stack = expressions.split(/(:.*;|\s)/).reduce((acc, op) => {
      if (!op || op === " ") return acc;
      const { pattern, callback } = this.#consumeOperation(op);
      return [callback(pattern)].flat(Infinity).reduce((res, fn) => {
        while (typeof fn === "function") fn = fn(res.pop());
        return [...res, fn].flat(Infinity);
      }, acc);
    }, this.#stack);
  }

  get stack() {
    return this.#stack;
  }
}
