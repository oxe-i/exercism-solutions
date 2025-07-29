export const proverb = (...inputs) => {
  if (!inputs.length) return "";
  const qualifier = inputs.at(-1)?.qualifier;
  return inputs
    .slice(0, (qualifier ? -2 : -1))
    .map((_, i) => inputs.slice(i, i + 2))
    .reduce((acc, [w1, w2]) => {
      return acc
           + `For want of a ${w1}`
           + " "
           + `the ${w2} was lost.\n`;
     },"") 
    + "And all for the want of a " 
    + (qualifier ? qualifier + " " : "")
    + `${inputs[0]}.`;
}
