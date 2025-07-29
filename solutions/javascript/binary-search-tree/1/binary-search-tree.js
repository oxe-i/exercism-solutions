export class BinarySearchTree {
  #value = undefined;
  #children = [null, null];
  
  constructor(value) {
    this.#value = value;
  }

  get data() {
    return this.#value;
  }
  
  get right() {
    return this.#children[1];
  }

  get left() {
    return this.#children[0];
  }

  insert(value) {
    if (this.#value === undefined) this.#value = value;
    else if (this.#value >= value) {
      if (!this.#children[0]) this.#children[0] = new BinarySearchTree(value);
      else this.#children[0].insert(value);
    }
    else {
      if (!this.#children[1]) this.#children[1] = new BinarySearchTree(value);
      else this.#children[1].insert(value);
    }
  }

  each(callback) {
    if (this.#children[0]) this.#children[0].each(callback);
    callback(this.#value);
    if (this.#children[1]) this.#children[1].each(callback);
  }
}
