export const abilityModifier = (score) => {
  if (score < 3) throw new Error("Ability scores must be at least 3");
  if (score > 18) throw new Error("Ability scores can be at most 18");
  return Math.floor((score - 10) / 2);
};

export class Character {
  #abilities = Array.from({ length: 6 }, Character.rollAbility);
  
  static #rollDice() {
    return 1 + ((Math.random() * 6) | 0);
  }
  
  static rollAbility() {
    return Array.from({ length: 4 }, Character.#rollDice)
      .sort()
      .slice(1)
      .reduce((sum, die) => die + sum);
  }

  get strength() {
    return this.#abilities[0];
  }

  get dexterity() {
    return this.#abilities[1];
  }

  get constitution() {
    return this.#abilities[2];
  }

  get intelligence() {
    return this.#abilities[3];
  }

  get wisdom() {
    return this.#abilities[4];
  }

  get charisma() {
    return this.#abilities[5];
  }

  get hitpoints() {
    return 10 + abilityModifier(this.constitution);
  }
}
