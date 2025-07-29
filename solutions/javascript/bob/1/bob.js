class BobMessages {
  static QUESTION = "Sure.";
  static YELL = "Whoa, chill out!";
  static YELLED_QUESTION = "Calm down, I know what I'm doing!";
  static SILENCE = "Fine. Be that way!";
  static DEFAULT = "Whatever.";
}

function isQuestion(message) {
  return /\?+\s*$/.test(message);
}

function isYelling(message) {
  return /^[^a-z]*[A-Z][^a-z]*$/.test(message);
}

function isSilence(message) {
  return /^\s*$/.test(message);
}

export const hey = (message) => {
  const silence = isSilence(message);
  if (silence) return BobMessages.SILENCE;
  
  const question = isQuestion(message);
  const yell = isYelling(message);
  if (question && yell) return BobMessages.YELLED_QUESTION;
  if (question) return BobMessages.QUESTION;
  if (yell) return BobMessages.YELL;
  
  return BobMessages.DEFAULT;
};
