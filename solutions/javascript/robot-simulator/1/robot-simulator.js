export class InvalidInputError extends Error {
  constructor(message) {
    super();
    this.message = message || 'Invalid Input';
  }
}

export class Robot {
  #bearing;
  #x;
  #y;

  constructor(options) {
    this.#bearing = "north";
    this.#x = 0;
    this.#y = 0;
  }
  
  get bearing() {
    return this.#bearing.slice(0);
  }

  get coordinates() {
    return [this.#x, this.#y];
  }

  place({ direction, x, y }) {
    const validDirections = ["north", "east", "south", "west"];
    if (!validDirections.includes(direction))
      throw new InvalidInputError;
    this.#bearing = direction;
    this.#x = x;
    this.#y = y;
  }

  #turnLeft() {
    switch (this.#bearing) {
      case "north":
        this.#bearing = "west";
        return;
      case "east":
        this.#bearing = "north";
        return;
      case "south":
        this.#bearing = "east";
        return;
      case "west":
        this.#bearing = "south";
        return;
    }
  }

  #turnRight() {
    switch (this.#bearing) {
      case "north":
        this.#bearing = "east";
        return;
      case "east":
        this.#bearing = "south";
        return;
      case "south":
        this.#bearing = "west";
        return;
      case "west":
        this.#bearing = "north";
        return;
    }
  }

  #advance() {
    switch (this.#bearing) {
      case "north":
        this.#y++;
        return;
      case "south":
        this.#y--;
        return;
      case "east":
        this.#x++;
        return;
      case "west":
        this.#x--;
        return;
    }
  }

  evaluate(instructions) {
    if (!instructions || typeof instructions[Symbol.iterator] !== "function")
      return;
    
    [...instructions].forEach(instruction => {
      switch (instruction) {
        case "R":
          this.#turnRight();
          break;
        case "L":
          this.#turnLeft();
          break;
        case "A":
          this.#advance();
          break;
        default:
          throw new InvalidInputError;
      }
    });
  }
}
