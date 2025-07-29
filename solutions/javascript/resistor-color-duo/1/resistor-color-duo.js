export const decodedValue = (colors) => {
  const COLOR_MAP = {
    black: 0, brown: 1, red: 2, orange: 3,
    yellow: 4, green: 5, blue: 6, violet: 7,
    grey: 8, white: 9
  };
  
  return colors
    .slice(0, 2)
    .reduce((acc, color) => {
      return 10 * acc + COLOR_MAP[color];
    }, 0);
};
