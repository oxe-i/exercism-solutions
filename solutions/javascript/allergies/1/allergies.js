//
// This is only a SKELETON file for the 'Allergies' exercise. It's been provided as a
// convenience to get you started writing code faster.
//

export class Allergies {
  #list;

  static get items() {
    return [
      "eggs",
      "peanuts",
      "shellfish",
      "strawberries",
      "tomatoes",
      "chocolate",
      "pollen",
      "cats"
    ];
  }
  
  constructor(score) {
    this.#list = Allergies.items.filter((_, idx) => {
      return score & (1 << idx);
    });
  }
  
  list() {
    return [...this.#list];
  }

  allergicTo(allergen) {
     return this.#list.includes(allergen);
  }
}
