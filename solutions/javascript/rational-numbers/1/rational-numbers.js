export class Rational {
  #num;
  #den;
  
  constructor(num, den) {
    this.#num = num;
    this.#den = den;
    this.reduce();
  }

  get num() {
    return this.#num;
  }

  get den() {
    return this.#den;
  }

  add(n2) {
    const common = n2.den * this.den;
    return new Rational(n2.den * this.num + this.den * n2.num, common);
  }

  sub(n2) {
    const common = n2.den * this.den;
    return new Rational(n2.den * this.num - this.den * n2.num, common);
  }

  mul(n2) {
    return new Rational(this.num * n2.num, this.den * n2.den);
  }

  div(n2) {
    return new Rational(this.num * n2.den, this.den * n2.num);
  }

  abs() {
    return new Rational(Math.abs(this.num), this.den);
  }

  exprational(n) {
    const [num, den] = n >= 0 ? [this.num, this.den] : [this.den, this.num];
    return new Rational(num ** n, den ** n);
  }

  #rootN(x, n) {
    const invert = x < 1 && x > 0;
    const value = invert ? (1 / x) : x;
    let low = 0;
    let high = value;
    while (low < high) {
      const mid = (low + high) / 2;
      const pw = mid ** n;
      if (pw === value)  
        return invert ? (1 / mid) : mid;
      if (pw < value) low = mid;
      else high = mid;
    }
    return invert ? (1 / low) : low;
  }

  expreal(x) {
    if (x < 0 && this.den % 2 == 0) 
      throw new Error("No root defined over the reals.")
    return this.#rootN(x ** this.num, this.den);
  }

  reduce() {
    if (!this.#num || !this.#den) {
      this.#num = 0;
      this.#den = 1;
      return this;
    }
    
    const isPositive = (this.#num > 0) ^ (this.#den < 0);
    this.#num = Math.abs(this.#num);
    this.#den = Math.abs(this.#den);

    if (this.#num < this.#den) {
      this.#num = isPositive ? this.#num : -this.#num;
      return this;
    }
    
    for (let gcd = this.#den; gcd > 1; --gcd) {
      if (!(this.#num % gcd) && !(this.#den % gcd)) {
        this.#num /= gcd;
        this.#den /= gcd;
        gcd = this.#den;
      }
    }

    this.#num = isPositive ? this.#num : -this.#num;
    return this;
  }
}
