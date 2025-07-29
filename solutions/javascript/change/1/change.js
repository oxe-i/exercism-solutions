export class Change {
  #negativeTotal() {
    return new Error("Negative totals are not allowed.");
  }

  #noCurrency(value) {
    return new Error(
      `The total ${value} cannot be represented in the given currency.`
    );
  }

  calculate(coinArray, target) {
    if (target < 0) throw this.#negativeTotal();

    const memo = new Map([
      coinArray.flatMap((coin) => [coin, [coin]]),
      [0, []],
    ]);

    const helper = (value) => {
      const memoRes = memo.get(value); //check memo
      if (memoRes) return [...memoRes];

      const coins = coinArray.filter((coin) => coin <= value);
      const results = coins.map((coin) => {
        try {
          const nextRes = helper(value - coin);
          nextRes.push(coin);
          return nextRes;
        } catch {
          return [];
        }
      });
      const validResults = results.filter(
        (result) => value === result.reduce((acc, val) => acc + val, 0)
      );
      if (!validResults.length) throw this.#noCurrency(value);
      const minResult = validResults
        .reduce((acc, result) => {
          return result.length < acc.length ? result : acc;
        })
        .sort((a, b) => a - b);

      memo.set(value, minResult);
      return [...minResult];
    };

    return helper(target);
  }
}
