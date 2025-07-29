export class List {
  constructor(values) {
    this.values = values ?? [];
  }

  append(sndList) {
    this.values = [...this.values, ...sndList.values];
    return this;
  }

  concat(lists) {
    for (const list of lists) this.append(list);
    return this;
  }

  filter(fn) {
    let filtered = [];
    for (const value of this.values) {
      if (fn(value)) filtered = [...filtered, value];
    }
    return new List(filtered);
  }

  map(fn) {
    let mapped = [];
    for (const value of this.values) {
      mapped = [...mapped, fn(value)];
    }
    return new List(mapped);
  }

  length() {
    let len = 0;
    let [head, ...others] = this.values;
    while (head) {
      len++;
      [head, ...others] = others;
    }
    return len;
  }

  foldl(fn, initial) {
    for (const value of this.values) {
      initial = fn(initial, value);
    }
    return initial;
  }

  foldr(fn, initial) {
    const [value, ...others] = this.values;
    if (value === undefined) return initial;
    return fn(new List(others).foldr(fn, initial), value);
  }

  reverse() {
    const [value, ...others] = this.values;
    if (value === undefined) return new List();
    return new List(others).reverse().append(new List([value]));
  }

  *[Symbol.iterator]() {
    for (const value of this.values) {
      yield value;
    }
  }
}
