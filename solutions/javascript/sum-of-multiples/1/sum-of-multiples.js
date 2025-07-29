export const sum = (factors, limit) => {
  const multiples = factors.reduce((set, factor) => {
    if (!factor) return set;
    let multiple = factor;
    while (multiple < limit) {
      set.add(multiple);
      multiple += factor;
    }
    return set;
  }, new Set([0]));
  return multiples.values().reduce((acc, val) => acc + val);
};
