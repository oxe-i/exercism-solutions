class CircularBuffer {
  #sz;
  #values;
  
  constructor(sz) {
    if (typeof sz !== "number" || sz === 0)
      throw new Error("Invalid size for buffer.");
    this.#sz = sz;
    this.#values = [];
  }

  write(val) {
    if (this.#values.length === this.#sz)
      throw new BufferFullError;
    this.#values.push(val);
  }

  read() {
    if (this.#values.length === 0)
      throw new BufferEmptyError;
    return this.#values.shift();
  }

  forceWrite(val) {
    if (this.#values.length === this.#sz) 
      this.#values.shift();
    this.write(val);
  }

  clear() {
    this.#values = [];
  }
}

export default CircularBuffer;

export class BufferFullError extends Error {
  constructor() {
    super("Can't write to a full buffer.");
  }
}

export class BufferEmptyError extends Error {
  constructor() {
    super("Can't read from an empty buffer.");
  }
}
