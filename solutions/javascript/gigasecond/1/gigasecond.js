export const gigasecond = (date) => {
  const milissecondsFromEpoch = date.getTime();
  const oneGigaSecondAsMillisecond = 1000000000 * 1000;
  return new Date(
    milissecondsFromEpoch +
    oneGigaSecondAsMillisecond
  );
};
