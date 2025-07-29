//
// This is only a SKELETON file for the 'Matching Brackets' exercise. It's been provided as a
// convenience to get you started writing code faster.
//

export const isPaired = (text) => {
  const open = "({[";
  const close = ")}]";
  const stack = [];
  for (const val of text) {
    if (open.includes(val)) {
      stack.push(val);
      continue;
    }
    if (close.includes(val)) {
      const last = stack.pop();
      if (last == "(" && val == ")")
        continue;
      if (last == "{" && val == "}")
        continue;
      if (last == "[" && val == "]")
        continue;
      return false;
    }
  }
  return !stack.length;
};
