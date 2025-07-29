//a simplified version of the worker pool found here https://nodejs.org/api/async_context.html#using-asyncresource-for-a-worker-thread-pool

const { EventEmitter } = require("node:events");
const { Worker } = require("node:worker_threads");
const { availableParallelism } = require("os"); //estimate number of available workers

const kWorkerFreedEvent = Symbol("kWorkerFreedEvent");

class WorkerPool extends EventEmitter {
  constructor(num) {
    super();
    this.workers = [];
    this.freeWorkers = [];
    this.tasks = [];

    for (let i = 0; i < num; ++i) {
      const worker = new Worker("./worker.js");
      this.workers.push(worker);
      this.freeWorkers.push(worker);
    }

    this.addListener(kWorkerFreedEvent, () => {
      if (this.tasks.length) {
        const { resolve, args } = this.tasks.shift();
        this.addTask(resolve, ...args);
      }
    });
  }

  addTask(resolve, ...args) {
    if (!this.freeWorkers.length) this.tasks.push({ resolve, args });
    else {
      const worker = this.freeWorkers.shift();
      worker.postMessage(args);
      worker.addListener("message", (value) => {
        resolve(value);
        this.freeWorkers.push(worker);
        this.emit(kWorkerFreedEvent);
      });
    }
  }

  close() {
    this.workers.forEach((worker) => {
      worker.terminate();
    });
  }
}

module.exports.parallelLetterFrequency = async (texts) => {
  //thread pool
  const workers = new WorkerPool(availableParallelism());

  //only for ASCII letters
  const sharedBuffer = new SharedArrayBuffer(
    Uint32Array.BYTES_PER_ELEMENT * 26
  );
  const view = new Uint32Array(sharedBuffer);

  const results = texts.map((text) => {
    return new Promise((resolve) => {
      const letters = text.match(/\p{L}/gu) ?? [];
      workers.addTask(resolve, sharedBuffer, letters);
    });
  });

  //counters for non-ASCII letters
  const counters = await Promise.all(results);
  workers.close();
  const initial = view.reduce((acc, value, idx) => {
    if (!value) return acc;
    acc[String.fromCharCode("a".charCodeAt(0) + idx)] = value;
    return acc;
  }, {});
  return counters.reduce((acc, counter) => {
    for (const [key, val] of Object.entries(counter))
      acc[key] = (acc[key] ?? 0) + val;
    return acc;
  }, initial);
};
