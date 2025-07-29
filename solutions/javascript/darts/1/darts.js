export const score = (x, y) => {
  const dist = Math.sqrt(x ** 2 + y ** 2);
  return (dist <= 10) + 4*(dist <= 5) + 5*(dist <= 1);
};
