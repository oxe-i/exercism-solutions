export const answer = (question) => {
  if (!/^What is -?\d+( (divided by|multiplied by|minus|plus) -?\d+)*\?$/.test(question)) {
    if (question.replaceAll(/(What is|\s|-?\d+|divided by|multiplied by|minus|plus|\?)/g, ""))
      throw new Error("Unknown operation");
    throw new Error("Syntax error");
  }

  const plusStream = (a) => (b) => (fn) => fn(a + b);
  const subStream = (a) => (b) => (fn) => fn(a - b);
  const multStream = (a) => (b) => (fn) => fn(a * b);
  const divStream = (a) => (b) => (fn) => fn(a / b);
  const initStream = (a) => (fn) => fn(a);
  const numStream = (a) => parseInt(a);
  const identity = (a) => a;

  const dispatchStream = (expression) => {
    switch (expression) {
      case "plus": return plusStream;
      case "minus": return subStream;
      case "multiplied by": return multStream;
      case "divided by": return divStream;
      default: return numStream(expression);
    }
  }
  
  const pattern = /(-?\d+|(divided by|multiplied by|minus|plus))/g;
  return [...question.matchAll(pattern)]
    .reduce((acc, match) => acc(dispatchStream(match[0])), initStream)
    .call(null, identity);
};
