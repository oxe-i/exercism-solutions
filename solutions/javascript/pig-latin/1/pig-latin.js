const translateWord = (word) => {
  if (/^([aeiou]|xr|yt)/.test(word)) return word + "ay";
  const match = word.match(/^(.)+?([aeiouy]|$)/);
  if (match[1] + match[2] === "qu") return word.slice(match[0].length) + match[0] + "ay";
  return word.slice(match[0].length - 1) + match[0].slice(0, -1) + "ay";
};

export const translate = (text) => text.split(" ").map(translateWord).join(" ");
