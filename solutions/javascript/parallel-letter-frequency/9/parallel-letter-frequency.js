const workerCode = `
  self.addEventListener("message", (event) => {
    const counter = event.data.reduce((acc, letter) => {
      const key = letter.toLowerCase();
      acc[key] = (acc[key] ?? 0) + 1; 
      return acc;
    }, {});

    self.postMessage(counter);
  });
`;

const blob = new Blob([workerCode], { type: "application/javascript" });

export const parallelLetterFrequency = async (texts) => {
  const numCores = navigator.hardwareConcurrency || 1;
  const workers = Array.from({ length: numCores }, (_, idx) => {
    const worker = {
      worker: new Worker(URL.createObjectURL(blob)),
      active: false,
    };
    return worker;
  });

  const results = texts.map((text) => {
    return new Promise((resolve) => {
      const crtWorker = workers.find(({ active }) => !active);
      if (!crtWorker) {
        const result = (text.match(/\p{L}/gu) ?? []).reduce((acc, letter) => {
          const key = letter.toLowerCase();
          acc[key] = (acc[key] ?? 0) + 1;
          return acc;
        }, {});
        resolve(result);
      } else {
        crtWorker.active = true;
        crtWorker.worker.addEventListener("message", (event) => {
          resolve(event.data);
          crtWorker.active = false;
        });
        crtWorker.worker.postMessage(text.match(/\p{L}/gu) ?? []);
      }
    });
  });

  const counters = await Promise.all(results);
  return counters.reduce((acc, counter) => {
    for (const [key, val] of Object.entries(counter))
      acc[key] = (acc[key] ?? 0) + val;
    return acc;
  }, {});
};