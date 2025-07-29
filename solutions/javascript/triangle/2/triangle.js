function isValidTriangle(sides) {
  if (sides.length !== 3 || sides.some(side => side <= 0)) return false;
  return sides.every((crtSide, crtIndex) => {
    const otherSides = sides.filter((_, otherIndex) => otherIndex !== crtIndex);
    return crtSide <= otherSides.reduce((sum, side) => sum + side, 0);
  });    
}

export class Triangle {
  constructor(...sides) { this.sides = sides; }

  get isEquilateral() {
    if (!isValidTriangle(this.sides)) return false;
    return this.sides.every(side => side === this.sides[0]);
  }

  get isIsosceles() {
    if (!isValidTriangle(this.sides)) return false;
    return new Set(this.sides).size <= 2;
  }

  get isScalene() {
    if (!isValidTriangle(this.sides)) return false;
    return new Set(this.sides).size === 3;
  }
}
