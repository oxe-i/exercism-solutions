export class CustomSet {
  static #BMASK = 15;
  static #BSHIFT = 4;

  #bitmap;
  #table;

  static #popcount(x) {
    let count = 0;
    while (x) {
      count += x & 1;
      x >>>= 1;
    }
    return count;
  }

  static #getBit(hash) {
    return 1 << (hash & CustomSet.#BMASK);
  }

  static #getPos(bit, bmp) {
    return CustomSet.#popcount((bit - 1) & bmp);
  }

  static #hash(value) {
    switch (typeof value) {
      case "number": {
        const buffer = new ArrayBuffer(8);
        new Float64Array(buffer)[0] = value;
        return new Uint8Array(buffer);
      }
      case "bigint": {
        const buffer = new ArrayBuffer(8);
        new BigUint64Array(buffer)[0] = value;
        return new Uint8Array(buffer);
      }
      case "object":
        return new TextEncoder().encode(JSON.stringify(value));
      default:
        return new TextEncoder().encode(String(value));
    }   
  }

  static #shiftHash(hashArr, idx, level) {
    if (level & 1) return hashArr[idx] >>> CustomSet.#BSHIFT;
    return hashArr[idx];
  }

  static #setIdx(level, arrLen) {
    return (level >>> 1) % arrLen;
  }

  #checkBit(bit) {
    return this.#bitmap & bit;
  }

  #entries() {
    return this.#table.flatMap((node) => {
      if (node instanceof CustomSet) return node.#entries();
      return { value: node.value, hashArr: node.hashArr };
    });
  }

  #fromEntries(entries) {
    entries.forEach(({ value, hashArr }) => {
      this.add(value, hashArr);
    });
    return this;
  }

  #copyTable() {
    return this.#table.map((node) => {
      if (node instanceof CustomSet) {
        return new CustomSet(node);
      }
      return { value: node.value, hashArr: node.hashArr };
    });
  }

  constructor(values) {
    this.#bitmap = 0;
    this.#table = [];

    if (values instanceof CustomSet) {
      this.#bitmap = values.#bitmap;
      this.#table = values.#copyTable();
      return;
    }

    if (values && typeof values[Symbol.iterator] === "function") {
      values.forEach((value) => {
        this.add(value);
      });
    }
  }

  get size() {
    return this.#entries().length;
  }

  empty() {
    return !this.#bitmap;
  }

  contains(value, hashArr = CustomSet.#hash(value)) {
    let level = 0;
    let set = this;
    let idx = CustomSet.#setIdx(level, hashArr.length);
    let hash = CustomSet.#shiftHash(hashArr, idx, level);
    let bit = CustomSet.#getBit(hash);
    let pos = CustomSet.#getPos(bit, set.#bitmap);

    while (set.#checkBit(bit)) {
      level++;
      if (set.#table[pos] instanceof CustomSet) {
        set = set.#table[pos];
        idx = CustomSet.#setIdx(level, hashArr.length);
        hash = CustomSet.#shiftHash(hashArr, idx, level);
        bit = CustomSet.#getBit(hash);
        pos = CustomSet.#getPos(bit, set.#bitmap);
        continue;
      }
      return set.#table[pos].value === value;
    }

    return false;
  }

  add(val, hArr = CustomSet.#hash(val)) {
    const helper = (set, value, hashArr, level) => {
      let idx = CustomSet.#setIdx(level, hashArr.length);
      let hash = CustomSet.#shiftHash(hashArr, idx, level);
      let bit = CustomSet.#getBit(hash);
      let pos = CustomSet.#getPos(bit, set.#bitmap);

      while (set.#checkBit(bit)) {
        level++;
        if (set.#table[pos] instanceof CustomSet) {
          set = set.#table[pos];
          idx = CustomSet.#setIdx(level, hashArr.length);
          hash = CustomSet.#shiftHash(hashArr, idx, level);
          bit = CustomSet.#getBit(hash);
          pos = CustomSet.#getPos(bit, set.#bitmap);
          continue;
        }
        const crtNode = set.#table[pos];
        if (value === crtNode.value) return;
        set.#table[pos] = new CustomSet();
        helper(set.#table[pos], crtNode.value, crtNode.hashArr, level);
        helper(set.#table[pos], value, hashArr, level);
        return;
      }

      set.#bitmap |= bit;
      set.#table = set.#table
        .slice(0, pos)
        .concat({ value: value, hashArr: hashArr }, set.#table.slice(pos));
    };

    helper(this, val, hArr, 0);
    return this;
  }

  subset(set2) {
    return (
      set2 instanceof CustomSet &&
      this.#entries().every(({ value, hashArr }) =>
        set2.contains(value, hashArr)
      )
    );
  }

  disjoint(set2) {
    return (
      set2 instanceof CustomSet &&
      this.#entries().every(
        ({ value, hashArr }) => !set2.contains(value, hashArr)
      )
    );
  }

  eql(set2) {
    return set2 instanceof CustomSet && this.subset(set2) && set2.subset(this);
  }

  union(set2) {
    const entries = this.#entries().concat(set2.#entries());
    return entries.reduce(
      (acc, { value, hashArr }) => acc.add(value, hashArr),
      new CustomSet()
    );
  }

  intersection(set2) {
    const entries = this.#entries();
    return new CustomSet().#fromEntries(
      entries.filter(({ value, hashArr }) => set2.contains(value, hashArr))
    );
  }

  difference(set2) {
    const entries = this.#entries();
    return new CustomSet().#fromEntries(
      entries.filter(({ value, hashArr }) => !set2.contains(value, hashArr))
    );
  }
}
