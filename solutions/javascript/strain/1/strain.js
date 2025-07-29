const partition = (list, pred) => {
  return list.reduce(([yes, no], val) => pred(val) ? [[...yes, val], no] : [yes, [...no, val]], [[], []]);
};

export const keep = (list, pred) => {
  return partition(list, pred)[0];
};

export const discard = (list, pred) => {
  return partition(list, pred)[1];
};
