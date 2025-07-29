export const truncate = (input) => {
  return input.match(/.{1,5}/u)?.[0] ?? "";
};
