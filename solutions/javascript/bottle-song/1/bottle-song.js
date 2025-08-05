export const recite = (initialBottlesCount, takeDownCount) => {
  const numberStr = (n) => {
    switch (n) {
      case 10: return "Ten";
      case 9 : return "Nine";
      case 8 : return "Eight";
      case 7 : return "Seven";
      case 6 : return "Six";
      case 5 : return "Five";
      case 4 : return "Four";
      case 3 : return "Three";
      case 2 : return "Two";
      case 1 : return "One";
      case 0 : return "no";
    }
  };
  const paragraph = (n) => {
    const opening =  `${numberStr(n)} green bottle${n == 1 ? "" : "s"} hanging on the wall,`;
    const interlude = "And if one green bottle should accidentally fall,";
    const finish = `There'll be ${numberStr(n - 1).toLowerCase()} green bottle${n == 2 ? "" : "s"} hanging on the wall.`;
    return [opening, opening, interlude, finish, ""];
  };
  const song = (start, count) => {
    return Array.from({ length: count }, () => paragraph(start--));
  }
  return song(initialBottlesCount, takeDownCount).flat().slice(0, -1);
};
