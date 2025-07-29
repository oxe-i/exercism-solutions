const { workerData, parentPort } = require("node:worker_threads");

const getCode = (letter) => letter.charCodeAt(0);

function countInWorker([sharedMem, letters]) {
  const view = new Uint16Array(sharedMem);
  for (const letter of letters) {
    const idx = getCode(letter.toLowerCase());
    Atomics.add(view, idx, 1);
  }
}

countInWorker(workerData);
parentPort.postMessage("done");
