// @ts-check

/**
 * Calculates the sum of the two input arrays.
 *
 * @param {number[]} array1
 * @param {number[]} array2
 * @returns {number} sum of the two arrays
 */
export const twoSum = (array1, array2) =>
  Number(array1.join("")) + Number(array2.join(""));


/**
 * Checks whether a number is a palindrome.
 *
 * @param {number} value
 * @returns {boolean} whether the number is a palindrome or not
 */
export const luckyNumber = (value) =>
  Number(value.toString().split("").reverse().join("")) === value;

/**
 * Determines the error message that should be shown to the user
 * for the given input value.
 *
 * @param {string|null|undefined} input
 * @returns {string} error message
 */
export function errorMessage(input) {
  if (!input) {
    return 'Required field';
  }
  else if (!Number(input)) {
    return 'Must be a number besides 0';
  }

  return '';
}
