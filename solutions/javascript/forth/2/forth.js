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
        () => {
          const sum = this.#binaryPrep().reduceRight((acc, x) => acc + x);
          this.#stack.push(sum);
        },
      ],
      [
        "*",
        () => {
          const mul = this.#binaryPrep().reduceRight((acc, x) => acc * x);
          this.#stack.push(mul);
        },
      ],
      [
        "/",
        () => {
          const [a, b] = this.#binaryPrep();
          if (a === 0) throw new Error("Division by zero");
          this.#stack.push((b / a) | 0);
        },
      ],
      [
        "-",
        () => {
          const sub = this.#binaryPrep().reduceRight((acc, x) => acc - x);
          this.#stack.push(sub);
        },
      ],
      [
        "dup",
        () => {
          const x = this.#unaryPrep();
          this.#stack.push(x, x);
        },
      ],
      [
        "swap",
        () => {
          const [a, b] = this.#binaryPrep();
          this.#stack.push(a, b);
        },
      ],
      [
        "drop",
        () => {
          this.#unaryPrep();
        },
      ],
      [
        "over",
        () => {
          const [a, b] = this.#binaryPrep();
          this.#stack.push(b, a, b);
        },
      ],
    ]);
    this.#userOps = new Map();
  }

  #prepareOps(string) {
    return string.replaceAll(/[+*]/g, (op) => `\\${op}`);
  }

  evaluate(expressions) {
    const userOpsPattern = this.#prepareOps(
      [...this.#userOps.keys()].join("|")
    );
    const pattern =
      "(" +
      (userOpsPattern ? `${userOpsPattern}|` : "") +
      "-?\\d+|[+*/-]|dup|swap|drop|over|:.*;)";
    const regex = new RegExp(pattern, "i");

    while (expressions.length) {
      expressions.trimStart();
      const match = expressions.match(regex);
      if (!match) throw new Error("Unknown command");
      const exp = match[0].toLowerCase();

      const ufn = this.#userOps.get(exp);
      if (ufn) {
        expressions = ufn()(expressions);
        continue;
      }

      expressions = expressions.slice(match.index + exp.length);

      if (/^-?\d+$/.test(exp)) {
        this.#stack.push(Number(exp));
        continue;
      }

      if (/:.*;/i.test(exp)) {
        const def = exp.match(/:\s+(.*?)\s(.*)\s+;/i);
        if (!def || /^\s*-?\d+\s*$/.test(def[1]))
          throw new Error("Invalid definition");

        const userOpName = def[1];
        const substitution = def[2].split(" ").reduce((acc, subs) => {
          const ufnSub = this.#userOps.get(subs);
          if (!ufnSub) return acc;
          return ufnSub(subs)(acc);
        }, def[2]);

        const userOp =
          (name = userOpName) =>
          (expression) => {
            return expression.replaceAll(
              new RegExp(this.#prepareOps(name), "gi"),
              substitution
            );
          };

        expressions = userOp()(expressions);
        this.#userOps.set(userOpName, userOp);
        continue;
      }

      const fn =
        this.#ops.get(exp) ??
        (() => {
          throw new Error("Unknown command");
        });
      fn();
    }
  }

  get stack() {
    return [...this.#stack];
  }
}
