export const reverseString = (ss) => [...ss].reduceRight((rs, s) => rs + s, "");
