import { describe, expect, test } from "@jest/globals";
import { truncate } from "./micro-blog";

describe("Custom tests", () => {
  test("ideograms", () => {
    const inputString = "吾輩は猫である。名前はたぬき。";
    const expected = "吾輩は猫で";
    const actual = truncate(inputString);
    expect(actual).toEqual(expected);
  });

  test("grapheme clusters", () => {
    const inputString = "💘🏳️‍🌈👩‍👩‍👦👨‍👩👨‍🎤";
    const expected = "💘🏳️‍🌈👩‍👩‍👦👨‍👩👨‍🎤";
    const actual = truncate(inputString);
    expect(actual).toEqual(expected);
  });

  test("grapheme and ASCII characters", () => {
    const inputString = "👩‍🦳Hi!👨‍💻";
    const expected = "👩‍🦳Hi!👨‍💻";
    const actual = truncate(inputString);
    expect(actual).toEqual(expected);
  });

  test("various unicode characters", () => {
    const inputString = "👨‍👧吾👩‍🌾👨‍❤️‍👨😀";
    const expected = "👨‍👧吾👩‍🌾👨‍❤️‍👨😀";
    const actual = truncate(inputString);
    expect(actual).toEqual(expected);
  })
});
