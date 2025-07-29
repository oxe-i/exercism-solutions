export class Element {
  constructor(value) {
    this.value = value;
    this.next = null;
  }
}

export class List {
  constructor(vals) {
    this.head = null;
    this.length = 0;
    while (vals?.length) {
      const elem = new Element(vals.shift());
      elem.next = this.head;
      this.head = elem;
      this.length++;
    }
  }

  add(elem) {
    elem.next = this.head;
    this.head = elem;
    this.length++;
  }

  toArray() {
    let ptr = this.head;
    const arr = [];
    while (ptr) {
      arr.push(ptr.value);
      ptr = ptr.next;
    }
    return arr;
  }

  reverse = () => new List(this.toArray());
}
