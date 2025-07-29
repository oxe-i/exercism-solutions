import { expect, test } from "@jest/globals";
import { triplets } from "./pythagorean-triplet";

function tripletsWithSum(sum, options = {}) {
  return triplets({ ...options, sum }).map((triplet) =>
    triplet.toArray().sort((a, b) => a - b)
  );
}

test(
  "triplets for large number",
  () => {
    expect(tripletsWithSum(30000)).toEqual([
      [1200, 14375, 14425],
      [1875, 14000, 14125],
      [5000, 12000, 13000],
      [6000, 11250, 12750],
      [7500, 10000, 12500],
    ]);
  },
  20 * 1000
);
