const { Worker } = require("node:worker_threads");
const { availableParallelism } = require("os");

module.exports.parallelLetterFrequency = async (texts) => {
  const workers = Array.from({ length: availableParallelism() }, () => {
    const worker = new Worker("./worker.js");
    return {
      worker: worker,
      active: false,
    };
  });

  const results = texts.map((text) => {
    return new Promise((resolve) => {
      const letters = text.match(/\p{L}/gu) ?? [];
      const crtWorker = workers.find((worker) => !worker.active);
      if (crtWorker) {
        crtWorker.active = true;
        crtWorker.worker.postMessage(letters);
        crtWorker.worker.addListener("message", (value) => {
          resolve(value);
          crtWorker.active = false;
        });
      } else {
        resolve(
          letters.reduce((acc, letter) => {
            const key = letter.toLowerCase();
            acc[key] = (acc[key] ?? 0) + 1;
            return acc;
          }, {})
        );
      }
    });
  });

  const counters = await Promise.all(results);
  workers.forEach((worker) => {
    worker.worker.terminate();
  });
  return counters.reduce((acc, counter) => {
    for (const [key, val] of Object.entries(counter))
      acc[key] = (acc[key] ?? 0) + val;
    return acc;
  }, {});

  /*
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
  }); */
};
