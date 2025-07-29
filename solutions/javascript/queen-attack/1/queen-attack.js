export class QueenAttack {
  constructor({ black, white } = { black: [0, 3], white: [7, 3] }) {
    if (
      black?.some((c) => c < 0 || c > 7) ||
      white?.some((c) => c < 0 || c > 7)
    )
      throw new Error("Queen must be placed on the board");
    if (black && white && black[0] === white[0] && black[1] === white[1])
      throw new Error("Queens cannot share the same space");
    this.black = black ?? [0, 3];
    this.white = white ?? [7, 3];
  }

  toString() {
    const board = Array.from({ length: 8 }, () => "_".repeat(8).split(""));
    board[this.white[0]][this.white[1]] = "W";
    board[this.black[0]][this.black[1]] = "B";
    return board.map((line) => line.join(" ")).join("\n");
  }

  get canAttack() {
    return (
      this.black[0] === this.white[0] ||
      this.black[1] === this.white[1] ||
      Math.abs(this.black[1] - this.white[1]) ===
        Math.abs(this.black[0] - this.white[0])
    );
  }
}
