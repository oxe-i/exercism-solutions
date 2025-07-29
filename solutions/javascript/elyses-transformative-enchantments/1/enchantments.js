// @ts-check

/**
 * Double every card in the deck.
 *
 * @param {number[]} deck
 *
 * @returns {number[]} deck with every card doubled
 */
export const seeingDouble = (deck) => deck.map((card) => 2 * card);

/**
 *  Creates triplicates of every 3 found in the deck.
 *
 * @param {number[]} deck
 *
 * @returns {number[]} deck with triplicate 3s
 */
export const threeOfEachThree = (deck) => 
  deck.reduce((accumulator, currentValue) => {
    if (currentValue == 3) {
      accumulator.push(3, 3, 3);
    }
    else {
      accumulator.push(currentValue);
    }

    return accumulator;
  }, Array(),
  );

/**
 * Extracts the middle two cards from a deck.
 * Assumes a deck is always 10 cards.
 *
 * @param {number[]} deck of 10 cards
 *
 * @returns {number[]} deck with only two middle cards
 */
export const middleTwo = (deck) => deck.slice((deck.length / 2) - 1, (deck.length / 2) + 1);

/**
 * Moves the outside two cards to the middle.
 *
 * @param {number[]} deck with even number of cards
 *
 * @returns {number[]} transformed deck
 */

export const sandwichTrick = (deck) => {
  const elements = [deck.pop(), deck.shift()];
  deck.splice((deck.length / 2), 0, ...elements);
  return deck;
}

/**
 * Removes every card from the deck except 2s.
 *
 * @param {number[]} deck
 *
 * @returns {number[]} deck with only 2s
 */
export const twoIsSpecial = (deck) => deck.filter((card) => card == 2);

/**
 * Returns a perfectly order deck from lowest to highest.
 *
 * @param {number[]} deck shuffled deck
 *
 * @returns {number[]} ordered deck
 */
export const perfectlyOrdered = (deck) => deck.sort((first, second) => {
  if (first < second) {
    return -1;
  }
  if (second > first) {
    return 1;
  }
  return 0;
});

/**
 * Reorders the deck so that the top card ends up at the bottom.
 *
 * @param {number[]} deck
 *
 * @returns {number[]} reordered deck
 */
export const reorder = (deck) => deck.reverse();
