export class BankAccount {
  #value;
  #isOpen;
  
  constructor() {
    this.#isOpen = false;
  }

  open() {
    if (this.#isOpen) throw new ValueError;
    this.#isOpen = true;
    this.#value = 0;
  }

  close() {
    if (!this.#isOpen) throw new ValueError;
    this.#isOpen = false;
    this.#value = 0;
  }

  deposit(value) {
    if (!this.#isOpen || value < 0) throw new ValueError;
    this.#value += value;
  }

  withdraw(value) {
    if (!this.#isOpen || value < 0 || value > this.#value) throw new ValueError;
    this.#value -= value;
  }

  get balance() {
    if (!this.#isOpen) throw new ValueError;
    return this.#value;
  }
}

export class ValueError extends Error {
  constructor() {
    super('Bank account error');
  }
}
