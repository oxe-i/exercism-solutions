import { PQueue } from "./pqueue";

class Bucket {
  constructor(capacity, current) {
    this.capacity = capacity;
    this.current = current;
  }
}

class State {
  constructor(b1, b2, steps) {
    if (b1 instanceof State) {
      this.b1 = new Bucket(b1.b1.capacity, b1.b1.current);
      this.b2 = new Bucket(b1.b2.capacity, b1.b2.current);
      this.steps = b1.steps;
      return;
    }
    this.b1 = new Bucket(b1, 0);
    this.b2 = new Bucket(b2, 0);
    this.steps = steps;
  }

  tick = (callback) => () => {
    this.steps++;
    callback();
    return this;
  };

  fillOne = this.tick(() => (this.b1.current = this.b1.capacity));
  fillTwo = this.tick(() => (this.b2.current = this.b2.capacity));
  emptyOne = this.tick(() => (this.b1.current = 0));
  emptyTwo = this.tick(() => (this.b2.current = 0));
  pourOneToTwo = this.tick(() => {
    const water = Math.min(this.b2.capacity - this.b2.current, this.b1.current);
    this.b2.current += water;
    this.b1.current -= water;
  });
  pourTwoToOne = this.tick(() => {
    const water = Math.min(this.b1.capacity - this.b1.current, this.b2.current);
    this.b1.current += water;
    this.b2.current -= water;
  });
}

class Result {
  constructor(steps, goalBucket, otherBucket) {
    this.moves = steps;
    this.goalBucket = goalBucket;
    this.otherBucket = otherBucket;
  }
}

export class TwoBucket {
  #state;
  #goal;
  #result;
  #constraint;

  constructor(b1, b2, goal, starter) {
    this.#state = new State(b1, b2, 0);
    this.#goal = goal;
    if (starter === "one") this.#state.fillOne();
    else this.#state.fillTwo();
    this.#constraint =
      starter === "one"
        ? (state) =>
            state.b1.current !== 0 || state.b2.current !== state.b2.capacity
        : (state) =>
            state.b2.current !== 0 || state.b1.current !== state.b1.capacity;
    this.#result = this.#solve();
    if (!this.#result) throw new Error("Goal not reachable.");
  }

  #solve() {
    const cost = (state) => state.steps;
    const heap = new PQueue((s1, s2) => cost(s1) <= cost(s2), this.#state);

    const hashFN = (state) => `${state.b1.current} + ${state.b2.current}`;
    const visited = new Set();

    while (heap.length) {
      const node = heap.pop();
      visited.add(hashFN(node));

      if (node.b1.current === this.#goal) {
        return new Result(node.steps, "one", node.b2.current);
      }
      if (node.b2.current === this.#goal) {
        return new Result(node.steps, "two", node.b1.current);
      }

      const nextNodes = [
        new State(node).fillOne(),
        new State(node).fillTwo(),
        new State(node).emptyOne(),
        new State(node).emptyTwo(),
        new State(node).pourOneToTwo(),
        new State(node).pourTwoToOne(),
      ];
      const validNodes = nextNodes.filter((next) => {
        return !visited.has(hashFN(next)) && this.#constraint(next);
      });

      heap.insert(...validNodes);
    }
  }

  solve = () => this.#result;
}
