export const encode = (nums) => {
  const max = 1 << 7;
  return nums.flatMap((num) => {
    const acc = [];
    acc.unshift(num & (max - 1));
    num >>>= 7;
    while (num) {
      acc.unshift((num & (max - 1)) | max);
      num >>>= 7;
    }
    return acc;
  });
};

export const decode = (bytes) => {
  const max = 1 << 7;
  const nums = [];
  while (bytes.length) {
    nums.unshift(0);
    let byte = bytes.shift();
    while (byte && byte & max) {
      nums[0] = (nums[0] | (byte ^ max)) << 7;
      byte = bytes.shift();
    }
    if (byte === undefined) throw new Error("Incomplete sequence");
    nums[0] = (nums[0] | byte) >>> 0;
  }
  return nums.reverse();
};
