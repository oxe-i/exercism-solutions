export const recite = (start, end = start) => {
  const days = [
    "first",
    "second",
    "third",
    "fourth",
    "fifth",
    "sixth",
    "seventh",
    "eighth",
    "ninth",
    "tenth",
    "eleventh",
    "twelfth",
  ];
  
  const gifts = [
    "a Partridge in a Pear Tree",
    "two Turtle Doves",
    "three French Hens",
    "four Calling Birds",
    "five Gold Rings",
    "six Geese-a-Laying",
    "seven Swans-a-Swimming",
    "eight Maids-a-Milking",
    "nine Ladies Dancing",
    "ten Lords-a-Leaping",
    "eleven Pipers Piping",
    "twelve Drummers Drumming"
  ];
  
  const verse = (n) => {
    const opening = `On the ${days[n - 1]} day of Christmas my true love gave to me: `;
    const allGifts = Array.from({ length: n }, () => gifts[--n]);   
    if (allGifts.length > 1) allGifts.splice(-1, 1, `and ${gifts[0]}`);
    return opening + allGifts.join(", ") + ".\n";
  };
  
  return Array.from({ length: 1 + end - start }, () => verse(start++)).join("\n");
};
