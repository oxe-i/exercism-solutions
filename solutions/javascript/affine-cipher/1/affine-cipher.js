const ZERO = "a".charCodeAt(0);

function factors(x) {
  if (!x) return new Set([1]);
  const results = new Set([1, x]);
  const upper = Math.floor(Math.sqrt(x));
  let factor = 2;
  while (factor <= upper) {
    if (x % factor === 0) {
      results.add(factor);
      results.add(x / factor);
    }
    factor++;
  }
  return results;
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
    const zero = "a".charCodeAt(0);
    const inc = fn(letter);
    return String.fromCharCode(zero + inc);
  };
}

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
  const m = 1 + "z".charCodeAt(0) - "a".charCodeAt(0);
  if (!areCoPrime(key.a, m)) throw new Error("a and m must be coprime.");

  const rotated = phrase.replaceAll(
    /./g,
    rotateLetter(encryption(m, key.a, key.b))
  );
  return recurSplit(rotated, 5).join(" ");
};

export const decode = (phrase, key) => {
  const m = 1 + "z".charCodeAt(0) - "a".charCodeAt(0);
  if (!areCoPrime(key.a, m)) throw new Error("a and m must be coprime.");

  const rotated = phrase.replaceAll(
    /./g,
    rotateLetter(decryption(m, key.a, key.b))
  );
  return rotated;
};
