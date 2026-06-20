# Leah's Luscious Lasagna

Welcome to Leah's Luscious Lasagna on Exercism's Factor Track.
If you need help running the tests or submitting your code, check out `HELP.md`.
If you get stuck on the exercise, check out `HINTS.md`, but try and solve it without using those first :)

## Introduction

In [Cargo Shuffle][cargo-shuffle] you met Factor's **data stack** and
the shuffle words that rearrange it. This exercise builds on that: you
will define words that *compute* with their inputs rather than just
moving them around.

## Comments

A `!` starts a line comment — Factor ignores everything from `!` to the
end of the line. The examples below use `!` both to annotate what code
does and to show what it would print.

## Words

A **word** is Factor's name for a function. Calling a word pops some
values from the top of the stack and pushes some values back.
`.` pops the top value and prints it; the integer arithmetic words
`+`, `-`, `*` pop two numbers and push the result:

```factor
2 3 + .    ! prints 5
8 3 - .    ! prints 5    (8 - 3, not 3 - 8)
2 3 * .    ! prints 6
```

A related word, `.s`, prints the *whole* data stack without consuming
anything — handy at the listener for seeing what a snippet leaves
behind. It's why later examples sometimes end in `.s` rather than `.`:
they leave more than one value on the stack, and `.s` shows them all.

The arithmetic words live in the `math` vocabulary, so a file that uses
them needs `math` in its `USING:` line.

## Stack effects

Every word is documented with a **stack effect** of the form
`( inputs -- outputs )`. It is the word's contract: this word pops the
inputs off the top of the stack and leaves the outputs in their place.
The names inside are documentation for humans — the stack itself is
positional, not named.

```factor
! + is specified as ( x y -- sum )
! . is specified as ( x   --     )
```

The top of the stack is the *right-hand* input. So `8 3 -` has `3` on
top, the stack effect is `( x y -- difference )`, and the result is
`8 - 3`.

A trailing `?` in the outputs is the convention for "a boolean", but
the lasagna exercise uses only numbers.

One shuffle word from Cargo Shuffle comes up below: `swap`
`( x y -- y x )`, which flips the top two values when they are in the
wrong order for the next word.

## Defining a word

`:` starts a word definition, the stack effect comes next, then the
body, then `;` ends it.

```factor
: square ( x -- x^2 ) dup * ;

4 square .    ! => 16
```

Factor's compiler checks that the body actually matches the declared
stack effect: a word that claims `( x -- y )` but leaves zero or two
values on the stack will not compile.

## Constants

`CONSTANT:` defines a name for a fixed value. A constant is itself a
word — calling it pushes the value onto the stack:

```factor
CONSTANT: pi 3

pi pi * .    ! => 9
```

`CONSTANT:` is core syntax and does not need a `USING:` line. Place
constants at the top of the file, before any word that uses them.

## Calling one word from another

A word's body can call any word already in scope, including ones you
defined earlier in the same file:

```factor
: double    ( x -- 2x ) 2 * ;
: quadruple ( x -- 4x ) double double ;

5 quadruple .    ! => 20
```

This is how the last task in the exercise reuses an earlier one.

## Naming conventions

Words and constants both use `lowercase-kebab-case`: lowercase letters
joined by hyphens (for example, `expected-bake-time`,
`preparation-time`).

[cargo-shuffle]: https://exercism.org/tracks/factor/exercises/cargo-shuffle

## Instructions

In this exercise you're going to write some code to help you cook a
brilliant lasagna from your favorite cooking book.

You have four tasks, all related to the time spent cooking the lasagna.

## 1. Store the expected bake time in a constant

Define the `expected-bake-time` constant, which should return how many
minutes the lasagna needs to bake in the oven.

According to the cooking book, lasagna needs to be in the oven for a
total of 40 minutes.

```factor
expected-bake-time .
! => 40
```

## 2. Calculate the preparation time in minutes

Define the `preparation-time` word. It takes the number of layers you
added to the lasagna off the stack and leaves behind how many minutes
you spent preparing it, assuming each layer takes 2 minutes to prepare.

```factor
4 preparation-time .
! => 8
```

## 3. Calculate the remaining oven time in minutes

Define the `remaining-time` word. It takes the number of minutes the
lasagna has already spent in the oven and leaves behind how many
minutes it still has to remain in there.

```factor
25 remaining-time .
! => 15
```

## 4. Calculate the total working time in minutes

Define the `total-working-time` word. It takes two arguments off the
stack — first the number of layers in the lasagna, then the number of
minutes the lasagna has already been in the oven — and leaves behind
the total time spent cooking so far: the preparation time plus the
time already in the oven.

```factor
3 20 total-working-time .
! => 26
```

## Source

### Created by

- @keiravillekode