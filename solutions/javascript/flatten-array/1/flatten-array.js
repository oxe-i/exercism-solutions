export const flatten = (array) => {
  const flattened = [];
  for (const value of array) {
    if (value === undefined || value === null) continue;
    if (value instanceof Object && Symbol.iterator in value) flattened.push(...flatten(value));
    else flattened.push(value);
  }
  return flattened;
};
