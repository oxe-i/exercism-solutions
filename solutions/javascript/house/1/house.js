export class House {
  static #lyrics = this.#getLyrics();

  static #getLyrics() {
    const protagonists = [
      "house that Jack built.",
      "malt",
      "rat",
      "cat",
      "dog",
      "cow with the crumpled horn",
      "maiden all forlorn",
      "man all tattered and torn",
      "priest all shaven and shorn",
      "rooster that crowed in the morn",
      "farmer sowing his corn",
      "horse and the hound and the horn",
    ];
    const actions = [
      "lay in",
      "ate",
      "killed",
      "worried",
      "tossed",
      "milked",
      "kissed",
      "married",
      "woke",
      "kept",
      "belonged to",
    ];
    return protagonists.map((protagonist, pIdx) => {
      return [`This is the ${protagonist}`].concat(
        actions
          .slice(0, pIdx)
          .map((action, aIdx) => {
            return `that ${action} the ${protagonists[aIdx]}`;
          })
          .reverse()
      );
    });
  }

  static verse(n) {
    return this.#lyrics.at(n - 1);
  }

  static verses(start, end) {
    return this.#lyrics.slice(start - 1, end).reduce((acc, verse) => {
      return acc.concat("", verse);
    });
  }
}