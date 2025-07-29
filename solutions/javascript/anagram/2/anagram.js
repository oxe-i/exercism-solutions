function getLetterMap(string) {
  return string.split("").reduce((acc, letter) => {
    acc.set(letter, (acc.get(letter) || 0) + 1);
    return acc;
  }, new Map());
}

function compareMaps(map1, map2) {
  if (map1.size !== map2.size) return false;
  for (const [key, value] of map1.entries()) {
    if (!map2.has(key) || map2.get(key) !== value)
      return false;
  }
  return true;
}

export const findAnagrams = (target, candidates) => {
  const normalizeText = (word) => word.toLowerCase();
  const normalizedTarget = target.toLowerCase();
  const targetLetterMap = getLetterMap(normalizedTarget);
  
  return candidates.filter((word) => {
    const normalizedWord = normalizeText(word);
    return normalizedTarget !== normalizedWord && compareMaps(targetLetterMap, getLetterMap(normalizedWord));
  });
};
