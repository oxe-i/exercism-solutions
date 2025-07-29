export const knapsack = (maximumWeight, items) => {
  const memo = new Map();
  const hashFN = (...args) => JSON.stringify(args);

  const helper = (max, rem) => {
    const hash = hashFN(max, rem);
    const prev = memo.get(hash);
    if (prev) return prev;

    const result = rem.reduce((acc, { value, weight }, idx) => {
      if (weight > max) return acc;
      const next = rem.toSpliced(idx, 1);
      return Math.max(acc, value + helper(max - weight, next));
    }, 0);

    memo.set(hash, result);
    return result;
  };

  return helper(maximumWeight, items);
};
