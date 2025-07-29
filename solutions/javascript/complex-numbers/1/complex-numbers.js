export class ComplexNumber {
  #coords;
  
  constructor(...coords) {
    this.#coords = coords;
  }

  get real() {
    return this.#coords[0];
  }

  get imag() {
    return this.#coords[1];
  }

  add(n2) {
    return new ComplexNumber(this.real + n2.real, this.imag + n2.imag);
  }

  sub(n2) {
    return new ComplexNumber(this.real - n2.real, this.imag - n2.imag);
  }

  reciprocal() {
    const squareAbs = this.real ** 2 + this.imag ** 2;
    return new ComplexNumber(this.real / squareAbs, -this.imag / squareAbs);
  }

  div(n2) {
    return this.mul(n2.reciprocal());
  }

  mul(n2) {
    return new ComplexNumber(
      this.real * n2.real - this.imag * n2.imag, 
      this.imag * n2.real + this.real * n2.imag
    );
  }

  get abs() {
    return Math.sqrt(this.real ** 2 + this.imag ** 2);
  }

  get conj() {
    return new ComplexNumber(this.real, -this.imag);
  }

  get exp() {
    const real = Math.exp(this.real);
    return new ComplexNumber(real * Math.cos(this.imag), real * Math.sin(this.imag));
  }
}
