const { parentPort } = require("node:worker_threads");

function codeIDX(letter) {
  return letter.charCodeAt(0) - "a".charCodeAt(0);
}

parentPort.addListener("message", ([sharedBuffer, letters]) => {
  const view = new Uint32Array(sharedBuffer);
  const counter = letters.reduce((acc, letter) => {
    letter = letter.toLowerCase();
    const key = codeIDX(letter);
    if (key <= 25) Atomics.add(view, key, 1);
    else acc[letter] = (acc[letter] ?? 0) + 1;
    return acc;
  }, {});
  parentPort.postMessage(counter);
});
