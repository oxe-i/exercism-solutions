// @ts-check

/**
 * Determine how many cards of a certain type there are in the deck
 *
 * @param {number[]} stack
 * @param {number} card
 *
 * @returns {number} number of cards of a single type there are in the deck
 */
export function cardTypeCheck(stack, card) {
  let numberOfCards = 0;
  stack.forEach((value) => {
    if (value === card) {
      numberOfCards++;
    }
  });
  return numberOfCards;
}

/**
 * Determine how many cards are odd or even
 *
 * @param {number[]} stack
 * @param {boolean} type the type of value to check for - odd or even
 * @returns {number} number of cards that are either odd or even (depending on `type`)
 */
export function determineOddEvenCards(stack, type) {
  let numberOfTypeCards = 0;
  for (const value of stack) {
    if ((value % 2 === 0) === type) {
      numberOfTypeCards++;
    }
  }
  return numberOfTypeCards;
}
