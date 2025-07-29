export class Matrix {
  constructor(matrixString) {
    this.matrix = matrixString
      .split("\n")
      .map(row => row.split(" ").map(Number));
  }

  get rows() {
    return [...this.matrix];
  }

  get columns() {
    if (this.matrix.length === 0) return [];
    return this.matrix[0].map((_, colIndex) => this.matrix.map(row => row[colIndex]));
  }
}
