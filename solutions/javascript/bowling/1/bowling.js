export class Bowling {
  #end;
  #frames;

  constructor() {
    this.#end = false;
    this.#frames = [[]];
  }

  roll(pins) {
    if (this.#end) throw new Error("Cannot roll after game is over");

    if (pins < 0) throw new Error("Negative roll is invalid");

    if (pins > 10) throw new Error("Pin count exceeds pins on the lane");

    if (this.#frames.length < 10) {
      const crtFrame = this.#frames.at(-1);
      switch (crtFrame.length) {
        case 0:
          crtFrame.push(pins);
          if (pins === 10) this.#frames.push([]);
          return;
        case 1:
          if (crtFrame[0] + pins > 10)
            throw new Error("Pin count exceeds pins on the lane");
          crtFrame.push(pins);
          this.#frames.push([]);
          return;
        default:
          this.#frames.push([]);
          this.roll(pins);
          return;
      }
    }

    const crtFrame = this.#frames.at(-1);
    switch (crtFrame.length) {
      case 0:
        crtFrame.push(pins);
        return;
      case 1:
        if (crtFrame[0] < 10 && crtFrame[0] + pins > 10)
          throw new Error("Pin count exceeds pins on the lane");
        crtFrame.push(pins);
        if (crtFrame[0] < 10 && crtFrame[0] + crtFrame[1] < 10)
          this.#end = true;
        return;
      case 2:
        if (crtFrame[0] === 10 && crtFrame[1] !== 10 && crtFrame[1] + pins > 10)
          throw new Error("Pin count exceeds pins on the lane");
        crtFrame.push(pins);
        this.#end = true;
    }
  }

  score() {
    if (!this.#end)
      throw new Error("Score cannot be taken until the end of the game");

    const sumOfPins = this.#frames.reduce((acc, frame) => {
      return acc + frame.reduce((s, c) => s + c);
    }, 0);
    const lastIDX = this.#frames.length - 1;
    const strikes = this.#frames.reduce((acc, frame, idx) => {
      if (frame[0] === 10 && idx !== lastIDX) acc.push(idx);
      return acc;
    }, []);
    const spares = this.#frames.reduce((acc, frame, idx) => {
      if (frame[0] !== 10 && frame[0] + frame[1] === 10 && idx !== lastIDX)
        acc.push(idx);
      return acc;
    }, []);
    const strikeScore = strikes.reduce((acc, idx) => {
      if (this.#frames[idx + 1].length < 2)
        return acc + this.#frames[idx + 1][0] + this.#frames[idx + 2][0];
      return acc + this.#frames[idx + 1].slice(0, 2).reduce((s, v) => s + v);
    }, 0);
    const spareScore = spares.reduce((acc, idx) => {
      return acc + this.#frames[idx + 1][0];
    }, 0);
    return sumOfPins + strikeScore + spareScore;
  }
}
