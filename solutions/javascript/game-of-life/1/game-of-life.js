class CellState {
  static DEAD = 0;
  static ALIVE = 1;
}

export class GameOfLife {
  constructor(grid) {
    this._grid = [...grid];
  }

  tick() {
    const getNeighbours = (row, col) => {
      return [
        this._grid?.[row - 1]?.[col - 1],
        this._grid?.[row - 1]?.[col],
        this._grid?.[row - 1]?.[col + 1],
        this._grid?.[row]?.[col - 1],
        this._grid?.[row]?.[col + 1],
        this._grid?.[row + 1]?.[col - 1],
        this._grid?.[row + 1]?.[col],
        this._grid?.[row + 1]?.[col + 1],
      ].filter((val) => val !== undefined);
    };

    this._grid = this._grid.map((row, rowIdx) => {
      return row.map((cell, colIdx) => {
        const liveNeighours = getNeighbours(rowIdx, colIdx).filter(
          (neighbour) => neighbour === CellState.ALIVE
        );
        switch (cell) {
          case CellState.DEAD:
            return liveNeighours.length === 3
              ? CellState.ALIVE
              : CellState.DEAD;
          case CellState.ALIVE:
            return liveNeighours.length === 2 || liveNeighours.length === 3
              ? CellState.ALIVE
              : CellState.DEAD;
          default:
            return CellState.DEAD;
        }
      });
    });
  }

  state() {
    return this._grid;
  }
}
