const actionsList = [
  "wink",
  "double blink",
  "close your eyes",
  "jump",
];

export const commands = (number) => {
  const list = actionsList.filter((_, idx) => number & (1 << idx));
  return number & (1 << 4) ? list.reverse() : list;
};
