export const encode = (str) => str.replaceAll(/(.)\1+/g, (match, ch) => `${match.length}${ch}`);

export const decode = (str) => str.replaceAll(/(\d+)(.)/g, (_, n, ch) => ch.repeat(Number(n)));
