function getLetterMap(string)
{
  return string.split("").reduce((acc, letter) => {
    if (!acc.has(letter)) acc.set(letter, 1);
    else acc.set(letter, acc.get(letter) + 1);
    return acc;
  }, new Map());
}

function compareMaps(map1, map2)
{
  return map1.size === map2.size && Array.from(map1.entries()).every(([key, value]) => {
    return map2.has(key) && map2.get(key) === value;
  });
}

export const findAnagrams = (target, candidates) => {
  const normalizedTarget = target.toLowerCase();
  const targetLetterMap = getLetterMap(normalizedTarget);
  return candidates
    .filter(word => {
      const normalizedWord = word.toLowerCase();
      return normalizedTarget != normalizedWord && 
             compareMaps(targetLetterMap, getLetterMap(normalizedWord));
    });
};
