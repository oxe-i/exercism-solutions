const partition = (list, pred) => list.reduce(([yes, no], val) => {
  return pred(val) ? [[...yes, val], no] : [yes, [...no, val]];
}, [[], []]);

export const keep = (list, pred) => partition(list, pred)[0];

export const discard = (list, pred) => partition(list, pred)[1];
