export class Forth {
  #stack;
  #ops;
  #userOps;

  #binaryPrep() {
    const a = this.#stack.pop();
    const b = this.#stack.pop();
    if (a === undefined && b === undefined) throw new Error("Stack empty");
    if (b === undefined) throw new Error("Only one value on the stack");
    return [a, b];
  }

  #unaryPrep() {
    const a = this.#stack.pop();
    if (a === undefined) throw new Error("Stack empty");
    return a;
  }

  constructor() {
    this.#stack = [];
    this.#ops = new Map([
      [
        "+",
        (exp) => {
          const sum = this.#binaryPrep().reduceRight((acc, x) => acc + x);
          this.#stack.push(sum);
          return exp.trim().slice(1);
        },
      ],
      [
        "*",
        (exp) => {
          const mul = this.#binaryPrep().reduceRight((acc, x) => acc * x);
          this.#stack.push(mul);
          return exp.trim().slice(1);
        },
      ],
      [
        "/",
        (exp) => {
          const [a, b] = this.#binaryPrep();
          if (a === 0) throw new Error("Division by zero");
          this.#stack.push((b / a) | 0);
          return exp.trim().slice(1);
        },
      ],
      [
        "-",
        (exp) => {
          const sub = this.#binaryPrep().reduceRight((acc, x) => acc - x);
          this.#stack.push(sub);
          return exp.trim().slice(1);
        },
      ],
      [
        "dup",
        (exp) => {
          const x = this.#unaryPrep();
          this.#stack.push(x, x);
          return exp.trim().slice(3);
        },
      ],
      [
        "swap",
        (exp) => {
          const [a, b] = this.#binaryPrep();
          this.#stack.push(a, b);
          return exp.trim().slice(4);
        },
      ],
      [
        "drop",
        (exp) => {
          this.#unaryPrep();
          return exp.trim().slice(4);
        },
      ],
      [
        "over",
        (exp) => {
          const [a, b] = this.#binaryPrep();
          this.#stack.push(b, a, b);
          return exp.trim().slice(4);
        },
      ],
    ]);
    this.#userOps = new Map();
  }

  #prepareOps(string) {
    return string.replaceAll(/[+*]/g, (op) => `\\${op}`);
  }

  evaluate(expressions) {
    const crtOps = this.#prepareOps([...this.#userOps.keys()].join("|"));
    const pattern =
      "(" +
      (crtOps ? `${crtOps}|` : "") +
      "-?\\d+|[+*/-]|dup|swap|drop|over|:.*;)";
    const regex = new RegExp(pattern, "i");
    while (expressions.length) {
      expressions.trimStart();
      const match = expressions.match(regex);
      if (!match) throw new Error("Unknown command");
      const exp = match[0].toLowerCase();
      if (/^-?\d+$/.test(exp)) {
        this.#stack.push(Number(exp));
        expressions = expressions.slice(match.index + exp.length);
        continue;
      }
      if (/:.*;/i.test(exp)) {
        const def = exp.match(/:\s+(.*?)\s(.*)\s+;/iu);
        if (!def || /^\s*-?\d+\s*$/.test(def[1]))
          throw new Error("Invalid definition");
        const userOpName = def[1].trim();
        const subsPattern = def[2].trim();
        const substitution = subsPattern.split(" ").reduce((acc, subs) => {
          const ufn = this.#userOps.get(subs);
          if (!ufn) return acc;
          return ufn(subs)(acc);
        }, subsPattern);
        const userOp =
          (name = userOpName) =>
          (expression) => {
            return expression.replaceAll(
              new RegExp(this.#prepareOps(name), "gi"),
              substitution
            );
          };
        expressions = userOp()(expressions.slice(match.index + exp.length));
        this.#userOps.set(userOpName, userOp);
        continue;
      }
      const ufn = this.#userOps.get(exp);
      if (ufn) {
        expressions = ufn()(expressions);
        continue;
      }
      const fn = this.#ops.get(exp);
      if (!fn) throw new Error("Unknown command");
      expressions = fn(expressions);
    }
  }

  get stack() {
    return [...this.#stack];
  }
}
