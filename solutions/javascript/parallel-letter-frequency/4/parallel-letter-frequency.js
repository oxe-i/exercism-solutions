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

export const parallelLetterFrequency = (texts) => {
  const promises = texts.map((text, idx) => {
    const letters = text.match(/\p{L}/gu) ?? [];
    return new Promise((resolve) => {
      const workerURL = URL.createObjectURL(blob);
      const worker = new Worker(workerURL);
      worker.postMessage(letters);
      worker.addEventListener("message", (event) => {
        resolve(event.data);
        worker.terminate();
        URL.revokeObjectURL(worker);
      });
    });
  });

  return Promise.all(promises).then((counters) => {
    return counters.reduce((acc, counter) => {
      for (const [key, val] of Object.entries(counter))
        acc[key] = (acc[key] ?? 0) + val;
      return acc;
    }, {});
  });
};
