function checkTriangleInequality(sides)
{
  const allSums = sides.reduce((acc, crtSide, crtIndex) => {
    const sums = sides.reduce((acc, otherSide, otherIndex) => {
      if (crtIndex !== otherIndex) acc.push(crtSide + otherSide);
      return acc;
    }, []);
    acc.set(crtIndex, sums);
    return acc;
  }, new Map());

  console.log(allSums);
  
  return sides.every((currSide, crtIndex) => {
    return currSide > 0 && 
      allSums.entries()
             .reduce((acc, [index, sum]) => {
               if (index !== crtIndex) return acc.concat(sum);
               return acc;
             }, [])
             .every(sum => sum >= currSide);
  });
}

function checkTriangle(sides)
{
  return sides.length === 3 && checkTriangleInequality(sides);
}

export class Triangle {
  constructor(...sides) {
    this.sides = sides;
  }

  get isEquilateral() {
    return checkTriangle(this.sides) && 
      this.sides.every(side => side === this.sides[0]);
  }

  get isIsosceles() {
    return checkTriangle(this.sides) &&
      (this.sides.filter(side => side === this.sides[0]).length >= 2 ||
      this.sides.filter(side => side === this.sides[1]).length >= 2);
  }

  get isScalene() {
    return checkTriangle(this.sides) &&
      this.sides.every((side1, index) => this.sides.slice(index + 1).every(side2 => side1 !== side2));
  }
}
