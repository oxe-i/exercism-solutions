class OrbitalPeriod {
  static get Mercury() {
    return 0.2408467;
  }

  static get Venus() {
    return 0.61519726;
  }

  static get Earth() {
    return 1.0;
  }

  static get Mars() {
    return 1.8808158;
  }

  static get Jupiter() {
    return 11.862615;
  }

  static get Saturn() {
    return 29.447498;
  }

  static get Uranus() {
    return 84.016846;
  }

  static get Neptune() {
    return 164.79132;
  }
}

function secondsToYears(seconds) {
  const secondsInYear = 60 * 60 * 24 * 365.25;
  return seconds / secondsInYear;
}

/**
  * params {string} planet
  * params {number} seconds
  * @returns {number}
  */
export const age = (planet, seconds) => {
  const normalizedPlanet = planet.trim().replace(/^\w/, (letter) => letter.toUpperCase());
  const orbitalPeriod = OrbitalPeriod[normalizedPlanet];
  if (orbitalPeriod === undefined) throw new Error("not a planet");
  
  const earthYears = secondsToYears(seconds);
  const yearsInPlanet = earthYears / orbitalPeriod;
  
  return Math.round(100 * yearsInPlanet) / 100; 
};
