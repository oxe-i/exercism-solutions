export class Forth {
  #patterns;
  #stack;

  static get #END() {
    return "#END";
  }

  static #stream(...values) {
    if (values.length === 0) return (gn) => Forth.#stream(gn);
    if (values[0] === Forth.#END) return values.slice(1);

    let fn = values.shift();
    if (typeof fn !== "function")
      return (gn) => Forth.#stream(gn, ...[fn, values].flat(Infinity));
    if (values.length === 0) throw new Error("Stack empty");

    fn = fn(values.shift());
    if (typeof fn !== "function")
      return (gn) => Forth.#stream(gn, ...[fn, values].flat(Infinity));
    if (values.length === 0) throw new Error("Only one value on the stack");

    fn = fn(values.shift());
    return (gn) => Forth.#stream(gn, ...[fn, values].flat(Infinity));
  }

  constructor() {
    this.#patterns = [
      [/^dup/i, () => (x) => [x, x]],
      [/^over/i, () => (x) => (y) => [y, x, y]],
      [/^drop/i, () => () => []],
      [/^swap/i, () => (x) => (y) => [y, x]],
      [/^-?\d+/i, (x) => Number(x)],
      [/^\+/i, () => (x) => (y) => y + x],
      [/^-/i, () => (x) => (y) => y - x],
      [/^\*/i, () => (x) => (y) => y * x],
      [
        /^\//i,
        () => (x) => {
          if (x === 0) throw new Error("Division by zero");
          return (y) => (y / x) | 0;
        },
      ],
      [
        /:\s(.*?)\s(.*)\s;/i,
        (x) => {
          const groups = x.match(/:\s(.*?)\s(.*)\s;/i);
          if (/^\s*-?\d+\s*$/.test(groups[1]))
            throw new Error("Invalid definition");
          const key = new RegExp(`^${RegExp.escape(groups[1])}`, "i");
          const subs = groups[2].split(" ").map((opName) => {
            for (const [pattern, callback] of this.#patterns)
              if (pattern.test(opName)) return callback(opName);
            throw new Error("Unknown command");
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
      let [match, fn] = [];
      for (const [pattern, callback] of this.#patterns) {
        [match, fn] = [expressions.match(pattern), callback];
        if (match) break;
      }
      if (!match) throw new Error("Unknown command");
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
