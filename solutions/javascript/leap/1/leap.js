//
// This is only a SKELETON file for the 'Leap' exercise. It's been provided as a
// convenience to get you started writing code faster.
//

export const isLeap = (year) => {
  const isDivisor = (n) => !(year % n);
  return isDivisor(400) || (isDivisor(4) && !isDivisor(100));
}
