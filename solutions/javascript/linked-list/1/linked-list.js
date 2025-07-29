export class LinkedList {
  constructor() {
    this._instance = this;
  }

  count() {
    let counter = 0;
    for (let crtInstance = this._instance; crtInstance; crtInstance = crtInstance._next) {
      counter += (crtInstance._value !== undefined);
    }
    return counter;
  }

  unshift(value) {
    if (this._instance._value === undefined) {
      this._instance._value = value;
      return;
    }

    const newHead = new LinkedList();
    newHead.unshift(value);
    newHead._instance._next = this._instance;
    this._instance = newHead._instance;
  }

  shift() {
    const crtValue = this._instance._value;
    this._instance.value = undefined;
    if (!this._instance._next) this._instance._next = new LinkedList();
    this._instance = this._instance._next;
    return crtValue;
  }

  push(value) {
    if (this._instance._next) {
      this._instance._next.push(value);
      return;
    }

    if (this._instance._value === undefined) {
      this._instance._value = value;
      return;
    }

    this._instance._next = new LinkedList();
    this._instance._next.push(value);
  }

  pop() {
    if (this._instance._next) {
      const nextValue = this._instance._next.pop();
      if (nextValue !== undefined) return nextValue;
      this._instance._next = undefined;
    }

    const crtValue = this._instance._value;
    this._instance._value = undefined;
    return crtValue;
  }

  delete(value) {
    if (this._instance._value === value) {
      this._instance._value = undefined;
      this._instance = this._instance._next;
      return true;
    }
    if (this._instance._next?.delete(value)) {
      this._instance._next = this._instance._next._instance;
    }
    return false;
  }
}
