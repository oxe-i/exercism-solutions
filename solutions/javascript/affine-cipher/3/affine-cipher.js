const ZERO = "a".charCodeAt(0);
const RANGE = 1 + "z".charCodeAt(0) - ZERO;

function factors(x) {
  if (!x) return new Set([1]);
  const set = new Set([1, x]);
  const upper = Math.floor(Math.sqrt(x));
  for (let factor = 2; factor <= upper; factor++) {
    if (x % factor === 0) {
      set.add(factor);
      set.add(x / factor);
    }
  }
  return set;
}

function encryption(m, a, b) {
  return (letter) => {
    const idx = letter.toLowerCase().charCodeAt(0) - ZERO;
    return (((a * idx + b) % m) + m) % m;
  };
}

function decryption(m, a, b) {
  return (letter) => {
    const y = letter.charCodeAt(0) - ZERO;
    const inv = MMI(a, m);
    return (((inv * (y - b)) % m) + m) % m;
  };
}

function rotateLetter(fn) {
  return (letter) => {
    if (/[\s\p{P}]/u.test(letter)) return "";
    if (/[^a-z]/i.test(letter)) return letter;
    const inc = fn(letter);
    return String.fromCharCode(ZERO + inc);
  };
}

/* based on Haskell implementation found here: 
 * https://en.wikibooks.org/wiki/Algorithm_Implementation/Mathematics/Extended_Euclidean_algorithm
 */
function MMI(x, y) {
  const egcd = (a, b) => {
    if (!a) return [b, 0, 1];
    const [g, s, t] = egcd(b % a, a);
    return [g, t - Math.floor(b / a) * s, s];
  };
  return egcd(x, y)[1] % y;
}

function recurSplit(iter, n) {
  if (!iter.length) return [];
  return [iter.slice(0, n), ...recurSplit(iter.slice(n), n)];
}

function areCoPrime(a, b) {
  const factorsA = factors(a);
  const factorsB = factors(b);
  const commonFactors = factorsA.intersection(factorsB);
  return commonFactors.size === 1;
}

export const encode = (phrase, key) => {
  if (!areCoPrime(key.a, RANGE)) throw new Error("a and m must be coprime.");

  const rotated = phrase.replaceAll(
    /./g,
    rotateLetter(encryption(RANGE, key.a, key.b))
  );
  
  return recurSplit(rotated, 5).join(" ");
};

export const decode = (phrase, key) => {
  if (!areCoPrime(key.a, RANGE)) throw new Error("a and m must be coprime.");

  const rotated = phrase.replaceAll(
    /./g,
    rotateLetter(decryption(RANGE, key.a, key.b))
  );
  
  return rotated;
};
