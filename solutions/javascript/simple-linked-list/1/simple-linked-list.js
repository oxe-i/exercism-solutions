//
// This is only a SKELETON file for the 'Simple Linked List' exercise. It's been provided as a
// convenience to get you started writing code faster.
//

export class Element {
  constructor(value) {
    this.value = value;
    this.next = null;
  }
}

export class List {
  constructor(values) {
    if (values === undefined) {
      this.head = null;
      this.length = 0;
      return;
    }
    if (Array.isArray(values)) {
      this.head = values.reduce((acc, value) => {
        const elem = new Element(value);
        elem.next = acc;
        return elem;
      }, null);
      this.length = values.length;
    }
  }

  add(elem) {
    elem.next = this.head;
    this.head = elem;
    this.length++;
  }

  toArray() {
    let ptr = this.head;
    return Array
      .from({ length: this.length }, () => {
        const val = ptr.value;
        ptr = ptr.next;
        return val;
      });
  }

  reverse() {
    return new List(this.toArray());
  }
  
}
