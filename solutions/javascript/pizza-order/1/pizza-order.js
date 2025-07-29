/// <reference path="./global.d.ts" />
//
// @ts-check

const addExtras = (...extras) => extras.reduce((accumulator, currentValue) => accumulator + (currentValue === 'ExtraSauce' ? 1 : 2), 0);

/**
 * Determine the prize of the pizza given the pizza and optional extras
 *
 * @param {Pizza} pizza name of the pizza to be made
 * @param {Extra[]} extras list of extras
 *
 * @returns {number} the price of the pizza
 */
export const pizzaPrice = (pizza, ...extras) => {    
  switch (pizza) {
    case 'Margherita':
      return 7 + addExtras(...extras);                    
    case 'Caprese' :
      return 9 + addExtras(...extras);
    case 'Formaggio':
      return 10 + addExtras(...extras);
    default:
      return 0;
  }
}
  
/**
 * Calculate the prize of the total order, given individual orders
 *
 * @param {PizzaOrder[]} pizzaOrders a list of pizza orders
 * @returns {number} the price of the total order
 */
export const orderPrice = (pizzaOrders) => {
  return pizzaOrders.reduce((accumulator, currentValue) => accumulator + pizzaPrice(currentValue.pizza, ...currentValue.extras), 0);
}