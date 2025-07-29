// @ts-check

/**
 * Generates a random starship registry number.
 *
 * @returns {string} the generated registry number.
 */
export function randomShipRegistryNumber() {
  return `NCC-${
    1000 + Math.floor(9000 * Math.random())
  }`;
}

/**
 * Generates a random stardate.
 *
 * @returns {number} a stardate between 41000 (inclusive) and 42000 (exclusive).
 */
export function randomStardate() {
  return 41000 + 1000 * Math.random();
}
/**
 * Generates a random planet class.
 *
 * @returns {string} a one-letter planet class.
 */
export function randomPlanetClass() {
  const planets = "D, H, J, K, L, M, N, R, T, Y"
    .split(", ");
  return planets[
    Math.floor(Math.random() * planets.length)
  ];
}
