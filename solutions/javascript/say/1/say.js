export const say = (n) => {
  if (n < 0 || n > 999999999999) 
    throw new Error("Number must be between 0 and 999,999,999,999.");
  if (n == 0) return "zero";
  
  const memo = new Map([
    [1, "one"],
    [2, "two"],
    [3, "three"],
    [4, "four"],
    [5, "five"],
    [6, "six"],
    [7, "seven"],
    [8, "eight"],
    [9, "nine"],
    [10, "ten"],
    [11, "eleven"],
    [12, "twelve"],
    [13, "thirteen"],
    [14, "fourteen"],
    [15, "fifteen"],
    [16, "sixteen"],
    [17, "seventeen"],
    [18, "eighteen"],
    [19, "nineteen"],
    [20, "twenty"],
    [30, "thirty"],
    [40, "forty"],
    [50, "fifty"],
    [60, "sixty"],
    [70, "seventy"],
    [80, "eighty"],
    [90, "ninety"]
  ]);
  
  const helper = (crt) => {
    const memoName = memo.get(crt);
    if (memoName) return memoName;
    
    if (crt >= 1000000000) {
      const rem = crt % 1000000000;
      const div = (crt - rem) / 1000000000;
      const result = `${helper(div)} billion` + (rem ? ` ${helper(rem)}` : "");
      memo.set(crt, result);
      return result;
    }
    
    if (crt >= 1000000) {
      const rem = crt % 1000000;
      const div = (crt - rem) / 1000000;
      const result = `${helper(div)} million` + (rem ? ` ${helper(rem)}` : "");
      memo.set(crt, result);
      return result;
    }
    
    if (crt >= 1000) {
      const rem = crt % 1000;
      const div = (crt - rem) / 1000;
      const result = `${helper(div)} thousand` + (rem ? ` ${helper(rem)}` : "");
      memo.set(crt, result);
      return result;
    }
    
    if (crt >= 100) {
      const rem = crt % 100;
      const div = (crt - rem) / 100;
      const result = `${helper(div)} hundred` + (rem ? ` ${helper(rem)}` : "");
      memo.set(crt, result);
      return result;
    }
    
    const rem = crt % 10;
    const div = crt - rem;
    const result = `${helper(div)}` + (rem ? `-${helper(rem)}` : "");
    memo.set(crt, result);
    return result;
  };

  return helper(n);
};
