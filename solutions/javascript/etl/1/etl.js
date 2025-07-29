export const transform = (old) => {
  return Object.entries(old)
    .reduce((acc, [val, keys]) => {
      return keys.reduce((acc2, key) => { 
        return { ...acc2, [key.toLowerCase()] : parseInt(val) };
      }, acc);
    }, {});
};
