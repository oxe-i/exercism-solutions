export const squareRoot = (n) => {
  let low = 1;
  let high = n
  while (true) {
    const mid = (low + high) / 2;
    const square = mid * mid;
    if (square == n) return mid;
    if (square < n) low = mid + 1;
    if (square > n) high = mid - 1;
  }
};
