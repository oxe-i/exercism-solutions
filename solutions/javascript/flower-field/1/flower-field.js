export const annotate = (input) => {
  const garden = input.map(row => [...row]);
  const count = (row, col) => {
    const neighbours = [
      garden?.[row]?.[col - 1],
      garden?.[row]?.[col + 1],
      garden?.[row + 1]?.[col - 1],
      garden?.[row + 1]?.[col],
      garden?.[row + 1]?.[col + 1],
      garden?.[row - 1]?.[col - 1],
      garden?.[row - 1]?.[col],
      garden?.[row - 1]?.[col + 1]
    ];
    return neighbours.filter(cell => cell === "*").length;
  };
  return garden.map((row, rowIdx) => {
    return row.map((cell, colIdx) => {
      if (cell == " ") return count(rowIdx, colIdx) || " ";
      return cell;
    }).join("");
  });
};
