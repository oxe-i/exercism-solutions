/**
 * Class to represent a priority queue using a 4-ary heap internally
 * It's possible to pass a custom compare function as argument to the constructor
 * The default behaviour is of a minheap with direct comparison of elements
 */
export class PQueue {
  #queue;
  #compare;

  constructor(compare = (a, b) => a <= b, ...elems) {
    this.#queue = [...elems];
    this.#compare = compare;
  }

  #getOptimalChild(n) {
    const children = [4 * n + 1, 4 * n + 2, 4 * n + 3, 4 * n + 4]
      .filter((index) => index < this.#queue.length)
      .map((index) => {
        return { idx: index, val: this.#queue[index] };
      });
    return !children.length
      ? undefined
      : children.reduce((acc, crt) => {
          if (this.#compare(crt.val, acc.val)) acc = crt;
          return acc;
        });
  }

  #getParent(n) {
    if (n <= 0) return undefined;
    const index = Math.floor((n - 1) / 4);
    return {
      idx: index,
      val: this.#queue[index],
    };
  }

  peek() {
    return this.#queue?.[0];
  }

  pop() {
    if (this.#queue.length === 0) return undefined;
    if (this.#queue.length === 1) return this.#queue.pop();

    const min = this.#queue[0];
    const end = this.#queue.pop();

    let n = 0;
    while (true) {
      const minChild = this.#getOptimalChild(n);
      if (!minChild || this.#compare(end, minChild.val)) {
        this.#queue[n] = end;
        break;
      }
      this.#queue[n] = minChild.val;
      n = minChild.idx;
    }

    return min;
  }

  insert(...vals) {
    for (const val of vals) {
      this.#queue.push(val);
      let n = this.#queue.length - 1;
      while (true) {
        const parent = this.#getParent(n);
        if (!parent || this.#compare(parent.val, val)) break;
        this.#queue[parent.idx] = val;
        this.#queue[n] = parent.val;
        n = parent.idx;
      }
    }
  }

  get length() {
    return this.#queue.length;
  }
}
