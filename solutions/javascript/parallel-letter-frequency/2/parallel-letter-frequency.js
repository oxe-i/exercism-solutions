const { Worker } = require("node:worker_threads");

const getLetter = String.fromCharCode;

module.exports.parallelLetterFrequency = (texts) => {
  const sharedMem = new SharedArrayBuffer(
    Uint16Array.BYTES_PER_ELEMENT * 100000
  );
  const view = new Uint16Array(sharedMem);

  const workers = texts.map((text) => {
    return new Promise((resolve) => {
      const worker = new Worker("./worker.js", {
        workerData: [sharedMem, text.match(/\p{L}/gu) ?? []],
      });

      worker.on("exit", resolve);
    });
  });

  return Promise.all(workers).then(() => {
    const res = {};
    for (let i = 0; i < view.length; ++i) {
      const value = Atomics.load(view, i);
      const char = getLetter(i);
      if (value) res[char] = value;
    }
    return res;
  });
};
