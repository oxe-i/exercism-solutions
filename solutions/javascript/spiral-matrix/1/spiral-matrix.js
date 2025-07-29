class State {
  static Direction = class { 
    #idx = 0;
    static #map = [[1, 0], [0, 1], [-1, 0], [0, -1]];

    #update() { this.#idx = (this.#idx + 1) % State.Direction.#map.length; }
    check(state) {
      if (!(state.matrix?.[state.y + this.dy]?.[state.x + this.dx] ?? true)) return;
      this.#update();
    }
    get dx() { return State.Direction.#map[this.#idx][0]; }
    get dy() { return State.Direction.#map[this.#idx][1]; }
  };

  #n = 1;
  #direction = new State.Direction();
  #lastN;
  
  constructor(dim) {
    this.matrix = Array.from({ length: dim }, () => Array(dim).fill(0)); 
    this.x = 0;
    this.y = 0;
    this.#lastN = dim * dim;
  }

  end() {
    return this.#n > this.#lastN;
  }

  tick() {
    if (this.end()) return;  
    this.matrix[this.y][this.x] = this.#n++;
    this.#direction.check(this); 
    this.x += this.#direction.dx;
    this.y += this.#direction.dy; 
    this.tick();
  }
}



export const spiralMatrix = (dim) => {
  const state = new State(dim);
  state.tick();
  return state.matrix;
};
