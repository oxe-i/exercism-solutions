# Resistor Color

Welcome to Resistor Color on Exercism's Lean Track.
If you need help running the tests or submitting your code, check out `HELP.md`.

## Instructions

If you want to build something using a Raspberry Pi, you'll probably use _resistors_.
For this exercise, you need to know two things about them:

- Each resistor has a resistance value.
- Resistors are small - so small in fact that if you printed the resistance value on them, it would be hard to read.

To get around this problem, manufacturers print color-coded bands onto the resistors to denote their resistance values.
Each band has a position and a numeric value.

The first 2 bands of a resistor have a simple encoding scheme: each color maps to a single number.

In this exercise you are going to create a helpful program so that you don't have to remember the values of the bands.

These colors are encoded as follows:

- black: 0
- brown: 1
- red: 2
- orange: 3
- yellow: 4
- green: 5
- blue: 6
- violet: 7
- grey: 8
- white: 9

The goal of this exercise is to create a way:

- to look up the numerical value associated with a particular color band
- to list the different band colors

Mnemonics map the colors to the numbers, that, when stored as an array, happen to map to their index in the array:
Better Be Right Or Your Great Big Values Go Wrong.

More information on the color encoding of resistors can be found in the [Electronic color code Wikipedia article][e-color-code].

[e-color-code]: https://en.wikipedia.org/wiki/Electronic_color_code

## Defining syntax

In this exercise, you must define syntax for colors using the `c*` prefix, e.g., `c*black`.
This syntax should expand at compile time to each color's corresponding value as a `Fin 10`, according to the instructions.
In the same way, you must define syntax for an array of all color values using `c*all`.

This task will likely require you to use either notations or macros.
You might want to check a [reference][macro-reference].

Because new syntax is expanded at compile time, any test would fail to compile unless all the required syntax is defined.
For this reason, instead of relying on traditional runtime tests, we check all values using theorems.
If a theorem typechecks, you may consider it a passing test.

If you work locally or in Lean's [online playground][playground], you will get instant feedback on whether any theorem succeeds or fails, and why it fails, through Lean InfoView.

[macro-reference]: https://lean-lang.org/doc/reference/latest/Notations-and-Macros/#language-extension
[playground]: https://live.lean-lang.org/

## Source

### Created by

- @oxe-i

### Based on

Maud de Vries, Erik Schierboom - https://github.com/exercism/problem-specifications/issues/1458