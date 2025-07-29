#!/usr/bin/env node

const fs = require("fs");
const path = require("path");

/**
 * Reads the given file and returns lines.
 *
 * This function works regardless of POSIX (LF) or windows (CRLF) encoding.
 *
 * @param {string} file path to file
 * @returns {string[]} the lines
 */
function readLines(file) {
  const data = fs.readFileSync(path.resolve(file), { encoding: "utf-8" });
  return data.split(/\r?\n/);
}

const VALID_OPTIONS = [
  "-n", // add line numbers
  "-l", // print file names where pattern is found
  "-i", // ignore case
  "-v", // reverse files results
  "-x", // match entire line
];

const ARGS = process.argv.slice(2);

const flags = [];
while (ARGS.length) {
  const arg = ARGS.shift();
  if (VALID_OPTIONS.includes(arg)) flags.push(arg);
  else {
    ARGS.unshift(arg);
    break;
  }
}

const pattern = ARGS.shift();

const files = [];
while (ARGS.length) {
  const arg = ARGS.shift();
  files.push(arg);
}

function processGREP() {
  if (!pattern) {
    console.error("No pattern");
    return;
  }
  if (!files.length) {
    console.error("No files to search");
    return;
  }

  const invert = flags.includes("-v");
  const onlyFileName = flags.includes("-l");
  const lineNum = flags.includes("-n");
  const allLine = flags.includes("-x");
  const caseInsensitive = flags.includes("-i");
  const addFileName = files.length > 1;

  const regex = ((_pattern) => {
    if (allLine) _pattern = `^${_pattern}$`;
    if (caseInsensitive) return new RegExp(_pattern, "i");
    return new RegExp(_pattern);
  })(pattern);

  const text = files.map(readLines);

  if (onlyFileName) {
    return text.reduce((acc, lines, txtIDX) => {
      if (lines.some((line) => invert ^ regex.test(line)))
        acc.push(files[txtIDX]);
      return acc;
    }, []);
  }
  
  return text.map((lines, txtIDX) => {
    return lines.reduce((acc, line, lineIDX) => {
      if (invert ^ regex.test(line)) {
        if (lineNum) line = `${lineIDX + 1}:${line}`;
        if (addFileName) line = `${files[txtIDX]}:${line}`;
        acc.push(line);
      }
      return acc;
    }, []);
  });
}

const results = processGREP();
results?.forEach((result) => {
  if (Array.isArray(result)) {
    result.forEach((line) => {
      console.log(line);
    });
  } else console.log(result);
});
