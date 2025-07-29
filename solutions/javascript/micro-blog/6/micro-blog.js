export const truncate = (input) =>
  [...new Intl.Segmenter("en", { granularity: "grapheme" }).segment(input)]
    .slice(0, 5)
    .reduce((ss, s) => ss + s.segment, "");
