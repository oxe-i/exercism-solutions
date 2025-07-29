class TriangleKind {
  static INVALID = 0;
  static EQUILATERAL = 1;
  static ISOSCELES = 2;
  static SCALENE = 3;
}

function isValidTriangle(sides) {
  if (sides.length !== 3 || sides.some(side => side <= 0)) return false;
  return sides.every((crtSide, crtIndex) => {
    const otherSides = sides.filter((_, otherIndex) => otherIndex !== crtIndex);
    return crtSide <= otherSides.reduce((sum, side) => sum + side, 0);
  });    
}

function classifyTriangle(sides) {
  if (!isValidTriangle(sides)) return TriangleKind.INVALID;
  const numOfDifferentSides = new Set(sides).size;
  switch (numOfDifferentSides) {
    case 3: return TriangleKind.SCALENE;
    case 2: return TriangleKind.ISOSCELES;
    case 1: return TriangleKind.EQUILATERAL;
  }
}

export class Triangle {
  constructor(...sides) { 
    this.sides = sides; 
    this.kind = classifyTriangle(sides);
  }

  get isEquilateral() {
    return this.kind === TriangleKind.EQUILATERAL;
  }

  get isIsosceles() {
    return this.kind === TriangleKind.ISOSCELES || this.kind === TriangleKind.EQUILATERAL;
  }

  get isScalene() {
    return this.kind === TriangleKind.SCALENE;
  }
}
