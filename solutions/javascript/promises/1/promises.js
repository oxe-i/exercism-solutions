export const promisify = (fn) => {
  return function (...args) {
    return new Promise((resolve, reject) => {
      fn(...args, (error, data) => {
        if (error) reject(error);
        else resolve(data);
      });
    });
  };
};

export const all = (promisesIter) => {
  return new Promise((resolve, reject) => {
    if (!promisesIter) resolve(undefined);
    const promises = [...promisesIter];
    if (!promises.length) resolve([]);
    const results = Array.from({ length: promises.length }, () => undefined);
    let count = 0;
    promises.forEach((promise, idx) => {
      promise.then(
        (value) => {
          results[idx] = value;
          count++;
          if (count === promises.length) resolve(results);
        },
        (error) => {
          reject(error);
        }
      );
    });
  });
};

export const allSettled = (promisesIter) => {
  return new Promise((resolve) => {
    if (!promisesIter) resolve(undefined);
    const promises = [...promisesIter];
    if (!promises.length) resolve([]);
    const results = Array.from({ length: promises.length }, () => undefined);
    let count = 0;
    promises.forEach((promise, idx) => {
      promise.then(
        (value) => {
          results[idx] = value;
          count++;
          if (count === promises.length) resolve(results);
        },
        (error) => {
          results[idx] = error;
          count++;
          if (count === promises.length) resolve(results);
        }
      );
    });
  });
};

export const race = (promisesIter) => {
  return new Promise((resolve, reject) => {
    if (!promisesIter) resolve(undefined);
    const promises = [...promisesIter];
    if (!promises.length) resolve([]);
    promises.forEach((promise) => {
      promise.then(
        (value) => {
          resolve(value);
        },
        (error) => {
          reject(error);
        }
      );
    });
  });
};

export const any = (promisesIter) => {
  return new Promise((resolve, reject) => {
    if (!promisesIter) resolve(undefined);
    const promises = [...promisesIter];
    if (!promises.length) resolve([]);
    let count = 0;
    const errors = Array.from({ length: promises.length }, () => undefined);
    promises.forEach((promise, idx) => {
      promise.then(
        (value) => {
          resolve(value);
        },
        (error) => {
          errors[idx] = error;
          count++;
          if (count === promises.length) reject(errors);
        }
      );
    });
  });
};
