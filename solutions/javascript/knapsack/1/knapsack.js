export const knapsack = (maximumWeight, items) => {
  const memo = new Map();
  const hash = (...args) => JSON.stringify(args);

  const helper = (max, rem) => {
    const prev = memo.get(hash(max, rem));
    if (prev) return prev;

    const result = rem.reduce((acc, {value, weight}, idx) => {
      if (weight > max) return acc;
      const next = rem.toSpliced(idx, 1);
      return Math.max(acc, value + helper(max - weight, next));
    }, 0);

    memo.set(hash(max, rem), result);
    return result;
  };

  return helper(maximumWeight, items);
};
