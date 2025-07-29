export const parallelLetterFrequency = async (texts) => {
  const letters = texts.reduce((acc, text) => {
    const matches = text
      .match(/\p{L}/gu)
      ?.map((letter) => letter.toLowerCase());
    return matches ? [...acc, ...matches] : acc;
  }, []);
  const map = {};
  await Promise.all(
    letters.map(async (key) => {
      map[key] = (map[key] ?? 0) + 1;
      return map;
    })
  );
  return map;
};

