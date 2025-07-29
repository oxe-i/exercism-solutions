export class Song {
  #song = (() => {
   const characters = [
      {
        character: "fly",
        entrance: "",
      },
      {
        character: "spider",
        entrance: "It wriggled and jiggled and tickled inside her.\n",
        action: " that wriggled and jiggled and tickled inside her"
      },
      {
        character: "bird",
        entrance: "How absurd to swallow a bird!\n"
      },
      {
        character: "cat",
        entrance: "Imagine that, to swallow a cat!\n"
      },
      {
        character: "dog",
        entrance: "What a hog, to swallow a dog!\n"
      },
      {
        character: "goat",
        entrance: "Just opened her throat and swallowed a goat!\n"
      },
      {
        character: "cow",
        entrance: "I don't know how she swallowed a cow!\n"
      }
   ];
   const verses = characters.reduce((acc, protagonist, idx) => {
     const verse = `I know an old lady who swallowed a ${protagonist.character}.\n` +
                   `${protagonist.entrance}` +
                   characters.slice(0, idx).reduceRight((catches, coadjuvant) => {
                     const catched = coadjuvant.character + (coadjuvant.action ?? "");
                     const phrase = `She swallowed the ${protagonist.character} to catch the ${catched}.\n`;
                     protagonist = coadjuvant;
                     return catches + phrase;
                   }, "") +
                   `I don't know why she swallowed the fly. ` +
                   `Perhaps she'll die.\n`;
     return [...acc, verse];
   }, []);
   const finale = {
     character: "horse",
     line: "She's dead, of course!"
   };       
   return verses.concat( 
     `I know an old lady who swallowed a ${finale.character}.\n` +
     `${finale.line}\n`
   );    
  })();
  
  verse = (idx) => this.#song.at(idx - 1);

  verses = (start, end) => this.#song.slice(start - 1, end).reduce((acc, verse) => acc + verse + "\n", "");
}
