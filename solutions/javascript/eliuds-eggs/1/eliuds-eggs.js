export const eggCount = (display) => {
  return !display ? 0 : (display & 1) + eggCount(display >>> 1);
};
