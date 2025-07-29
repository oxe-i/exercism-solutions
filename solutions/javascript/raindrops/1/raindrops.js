/**
  *  param {number} number  
  *  @returns {string}
  */
export const convert = (number) => {
  return (number % 3 == 0 ? "Pling" : "") +
         (number % 5 == 0 ? "Plang" : "") +
         (number % 7 == 0 ? "Plong" : "") ||
         String(number);
};
