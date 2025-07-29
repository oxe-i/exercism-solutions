export const rows = (num) => {
  if (num === 0) return [];
  
  const prev = rows(num - 1);
  const crt = Array.from({ length: num }, (_, idx) => {
    if (idx === 0 || idx === num - 1) return 1;
    const last = prev.at(-1);
    return last[idx - 1] + last[idx];
  });
  prev.push(crt);
  
  return prev;
};
