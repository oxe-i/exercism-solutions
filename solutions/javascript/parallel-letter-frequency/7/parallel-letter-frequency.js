const { Worker } = require("node:worker_threads");
const { availableParallelism } = require("os"); //estimate number of available workers

module.exports.parallelLetterFrequency = async (texts) => {
  //thread pool
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
        //if there is no worker available, counts in main thread
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

  const counters = await Promise.all(results); //all threads finished working
  workers.forEach((worker) => {
    worker.worker.terminate(); //terminate all threads before returning
  });
  return counters.reduce((acc, counter) => {
    for (const [key, val] of Object.entries(counter))
      acc[key] = (acc[key] ?? 0) + val;
    return acc;
  }, {});
};
