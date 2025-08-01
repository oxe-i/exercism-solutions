// @ts-check
//
// The line above enables type checking for this file. Various IDEs interpret
// the @ts-check directive. It will give you helpful autocompletion when
// implementing this exercise.

/**
 * Determines whether or not you need a license to operate a certain kind of vehicle.
 *
 * @param {string} kind
 * @returns {boolean} whether a license is required
 */
export const needsLicense = (kind) =>
  kind === "car" || kind === "truck";

/**
 * Helps choosing between two options by recommending the one that
 * comes first in dictionary order.
 *
 * @param {string} option1
 * @param {string} option2
 * @returns {string} a sentence of advice which option to choose
 */
  
export const chooseVehicle = (option1, option2) => {
  function lesser (option1, option2) {
    if (option1 < option2) return option1;
    else return option2;
  }
  
  return`${lesser(option1, option2)} is clearly the better choice.`;
}

/**
 * Calculates an estimate for the price of a used vehicle in the dealership
 * based on the original price and the age of the vehicle.
 *
 * @param {number} originalPrice
 * @param {number} age
 * @returns {number} expected resell price in the dealership
 */
export const calculateResellPrice = (originalPrice, age) =>
  originalPrice * Array.of(age).map((age) => {
    if (age < 3) return 0.8
    else if (age >=3 && age <= 10) return 0.7
    else return 0.5
  })
