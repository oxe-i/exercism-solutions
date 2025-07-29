#!/usr/bin/env node

// The above line is a shebang. On Unix-like operating systems, or environments,
// this will allow the script to be run by node, and thus turn this JavaScript
// file into an executable. In other words, to execute this file, you may run
// the following from your terminal:
//
// ./grep.js args
//
// If you don't have a Unix-like operating system or environment, for example
// Windows without WSL, you can use the following inside a window terminal,
// such as cmd.exe:
//
// node grep.js args
//
// Read more about shebangs here: https://en.wikipedia.org/wiki/Shebang_(Unix)

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
  "n", // add line numbers
  "l", // print file names where pattern is found
  "i", // ignore case
  "v", // reverse files results
  "x", // match entire line
];

const ARGS = process.argv.slice(2);

const flags = [];
while (ARGS.length) {
  const ARG = ARGS.shift();
  if (new RegExp(`(-${VALID_OPTIONS.join("|-")})`).test(ARG)) flags.push(ARG);
  else {
    ARGS.unshift(ARG);
    break;
  }
}

const pattern = ARGS.shift();

const files = [];
while (ARGS.length) {
  const ARG = ARGS.shift();
  files.push(ARG);
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
  return text.map((lines, txtIDX) => {
    if (onlyFileName) {
      return lines.some((line) => invert ^ regex.test(line))
        ? [files[txtIDX]]
        : [];
    }
    const matches = lines.reduce((acc, line, idx) => {
      if (invert ^ regex.test(line)) {
        if (lineNum) line = `${idx + 1}:${line}`;
        if (addFileName) line = `${files[txtIDX]}:${line}`;
        acc.push(line);
      }
      return acc;
    }, []);
    return matches;
  });
}

const results = processGREP();
results.forEach((result) => {
  result.forEach((line) => {
    console.log(line);
  });
});

//
// This is only a SKELETON file for the 'Grep' exercise. It's been provided as a
// convenience to get you started writing code faster.
//
// This file should *not* export a function. Use ARGS to determine what to grep
// and use console.log(output) to write to the standard output.
