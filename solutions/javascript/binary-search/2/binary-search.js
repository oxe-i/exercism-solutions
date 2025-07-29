export const find = (list, value) => {
  let low = 0;
  let high = list.length - 1;
  while (low <= high) {
    const mid = (low + high) >> 1;
    if (list[mid] === value) return mid;
    if (list[mid] > value) high = mid - 1;
    else low = mid + 1;
  }
  throw new Error("Value not in array");
};
