const { parentPort } = require("node:worker_threads");

parentPort.addListener("message", (letters) => {
  const counter = letters.reduce((acc, letter) => {
    const key = letter.toLowerCase();
    acc[key] = (acc[key] ?? 0) + 1;
    return acc;
  }, {});
  parentPort.postMessage(counter);
});
