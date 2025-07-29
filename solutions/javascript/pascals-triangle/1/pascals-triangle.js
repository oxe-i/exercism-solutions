export const rows = (num) => {
  if (num === 0) return [];
  
  const previousRows = rows(num - 1);
  const nextRow = new Array(num).fill(0).map((_, index) => {
    if (index === 0 || index === num - 1) return 1;
    return previousRows.at(-1)[index - 1] + previousRows.at(-1)[index];
  });
  previousRows.push(nextRow);
  
  return previousRows;
};
