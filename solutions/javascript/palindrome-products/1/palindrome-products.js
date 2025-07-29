function isPalindrome(num) {
  const numString = num.toString();
  return numString === numString.split("").reverse().join("");
}

function maxProduct(min, max) {
  let result = Number.MIN_VALUE;
  
  for (let fst = max; fst >= min; fst--) {
    if (fst * fst <= result) return result;
    for (let snd = fst; snd >= min; snd--) {
      const product = fst * snd;
      if (product <= result) break;
      if (isPalindrome(product)) result = product;
    }
  }
  
  return null;
}

function minProduct(min, max) {
  let result = Number.MAX_VALUE;
  
  for (let fst = min; fst <= max; fst++) {
    if (fst * fst >= result) return result;
    for (let snd = fst; snd <= max; snd++) {
      const product = fst * snd;
      if (product >= result) break;
      if (isPalindrome(product)) result = product;
    }
  }
  
  return null;
}

function getMaxFactors(num, min, max) {
  const factors = [];  
  if (!num) return factors;
  
  for (let fst = max; fst >= min; fst--) {
    if (fst * fst < num) return factors;
    for (let snd = fst; snd >= min; snd--) {
      const product = fst * snd;
      if (product === num) factors.push([fst, snd]);
      if (product < num) break;
    }
  }
  
  return factors;
}

function getMinFactors(num, min, max) {
  const factors = [];
  if (!num) return factors;
  
  for (let fst = min; fst <= max; fst++) {
    if (fst * fst > num) return factors;
    for (let snd = fst; snd <= max; snd++) {
      const product = fst * snd;
      if (product === num) factors.push([fst, snd]);
      if (product > num) break;
    }
  }
  
  return factors;
}

export class Palindromes {  
  static generate(factors) {
    const minFactor = factors["minFactor"];
    const maxFactor = factors["maxFactor"];

    if (minFactor > maxFactor) throw new Error("min must be <= max");
    
    const smallestProduct = minProduct(minFactor, maxFactor);
    const largestProduct = maxProduct(minFactor, maxFactor);
    
    return {
      smallest: {value: smallestProduct, factors: getMinFactors(smallestProduct, minFactor, maxFactor)},
      largest: {value: largestProduct, factors: getMaxFactors(largestProduct, minFactor, maxFactor)}
    };
  }
}
