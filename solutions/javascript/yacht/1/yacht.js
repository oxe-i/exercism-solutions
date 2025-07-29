const ones = (dice) => dice.reduce((count, die) => count + (die === 1), 0);
const twos = (dice) => 2 * dice.reduce((count, die) => count + (die === 2), 0);
const threes = (dice) => 3 * dice.reduce((count, die) => count + (die === 3), 0);
const fours = (dice) => 4 * dice.reduce((count, die) => count + (die === 4), 0);
const fives = (dice) => 5 * dice.reduce((count, die) => count + (die === 5), 0);
const sixes = (dice) => 6 * dice.reduce((count, die) => count + (die === 6), 0);
const partition = (dice) => {
  const fst = dice.filter((die) => die === dice[0]);
  const snd = dice
    .filter((die) => die !== dice[0])
    .filter((die, _, self) => die === self[0]);
  return [fst, snd];
};
const full = (dice) => {
  const [fst, snd] = partition(dice);
  if (Math.max(fst.length, snd.length) !== 3) return 0;
  return fst.length * fst[0] + snd.length * snd[0];
};
const four = (dice) => {
  const [fst, snd] = partition(dice);
  if (fst.length >= 4) return fst[0] * 4;
  if (snd.length >= 4) return snd[0] * 4;
  return 0;
};
const little = (dice) => 30 * dice.sort().every((die, idx) => die === idx + 1);
const big = (dice) => 30 * dice.sort().every((die, idx) => die === idx + 2);
const choice = (dice) => dice.reduce((acc, die) => acc + die);
const yacht = (dice) => 50 * dice.every((die) => die === dice[0]);

export const score = (dice, category) => {
  const dispatchTable = [
    ones, twos, threes,
    fours, fives, sixes,
    full, four, little,
    big, choice, yacht,
  ];
  return dispatchTable.find((fn) => category.startsWith(fn.name))(dice);
};

