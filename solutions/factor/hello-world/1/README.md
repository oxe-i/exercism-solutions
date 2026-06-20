# Hello World

Welcome to Hello World on Exercism's Factor Track.
If you need help running the tests or submitting your code, check out `HELP.md`.

## Instructions

The classical introductory exercise.
Just say "Hello, World!".

["Hello, World!"][hello-world] is the traditional first program for beginning programming in a new language or environment.

The objectives are simple:

- Modify the provided code so that it produces the string "Hello, World!".
- Run the test suite and make sure that it succeeds.
- Submit your solution and check it at the website.

If everything goes well, you will be ready to fetch your first real exercise.

[hello-world]: https://en.wikipedia.org/wiki/%22Hello,_world!%22_program

## Implementation notes

A Factor program is built from *words*, grouped into
*vocabularies*.

Factor loads a *vocabulary* from a directory of the same name, so the `hello-world` vocabulary is the file `hello-world.factor` inside a `hello-world/` directory.

`: say-hello ( -- str ) … ;` defines the word `say-hello`.
The part in parentheses is its *stack effect*: nothing to the left of `--` means it takes no input, and `str` to the right means it leaves one value (the name is only documentation, not a type).
Everything between the stack effect and the closing `;` is the body — the code that runs when the word is called.

The test suite calls `say-hello` and checks the value it leaves on the stack.
Change the body so the word leaves `"Hello, World!"` instead, then run the tests.

## Source

### Created by

- @kytrinyx

### Contributed to by

- @catb0t
- @sjwarner-bp

### Based on

This is an exercise to introduce users to using Exercism - https://en.wikipedia.org/wiki/%22Hello,_world!%22_program