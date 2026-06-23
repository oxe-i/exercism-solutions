# Backyard Birdcount

Welcome to Backyard Birdcount on Exercism's Factor Track.
If you need help running the tests or submitting your code, check out `HELP.md`.
If you get stuck on the exercise, check out `HINTS.md`, but try and solve it without using those first :)

## Introduction

Most of the time Factor handles iteration through combinators like
`each`, `map`, and `count`. Sometimes, though, the cleanest way to
spell a computation is **recursion** — a word that calls itself.

## Defining a recursive word

A `:` definition can call itself directly. The compiler can usually
infer the stack effect; if it can't, you can add the `recursive`
modifier to ask it to assume self-consistency:

```factor
: count-down ( n -- )
    dup 0 = [ drop ] [ dup . 1 - count-down ] if ;

5 count-down
! prints 5 4 3 2 1
```

## Empty-or-not branching

`if-empty` (in [`sequences`][sequences]) is the natural recursion
base case:

```
if-empty ( seq emptyquot nonemptyquot -- )
```

```factor
{ 4 0 9 } [ "empty" ] [ "got data" ] if-empty .
! => "got data"
```

`emptyquot` runs with the (empty) sequence already consumed;
`nonemptyquot` runs with the sequence still on the stack.

## `cond` — a chain of guarded branches

When your recursion has more than two cases, `cond` (in
[`combinators`][combinators]) keeps the code readable:

```factor
: classify ( n -- label )
    {
        { [ dup 0 < ] [ drop "negative" ] }
        { [ dup 0 = ] [ drop "zero"     ] }
        [ drop "positive" ]
    } cond ;
```

## Forward references with `DEFER:`

A `:` definition can call itself directly, but when two words call
*each other* the parser sees the first one before the second
exists. `DEFER:` reserves a name so the first definition can
compile:

```factor
DEFER: even?

: odd? ( n -- ? ) dup 0 = [ drop f ] [ 1 - even? ] if ;
: even? ( n -- ? ) dup 0 = [ drop t ] [ 1 - odd? ] if ;
```

`DEFER:` is also handy when a helper word is more naturally read
*after* the word that uses it.

[sequences]: https://docs.factorcode.org/content/vocab-sequences.html
[combinators]: https://docs.factorcode.org/content/vocab-combinators.html

## Instructions

You're keeping daily counts of how many birds visit your garden. The
data is stored as an array of integers, with **today's count first**.

## 1. Today's count

Define `today` to take an array of daily counts off the stack and
return today's count, or `f` if the array is empty.

```factor
{ 2 5 1 } today .
! => 2

{ } today .
! => f
```

## 2. Increment today's count

Define `increment-day-count` to return a new array with today's
count increased by one. If the input is empty, return `{ 1 }`.

```factor
{ 4 0 2 } increment-day-count .
! => { 5 0 2 }

{ } increment-day-count .
! => { 1 }
```

## 3. Was there a day with no birds?

Define `has-day-without-birds?` to return `t` if at least one day
recorded zero birds, otherwise `f`.

**Use recursion** rather than `any?` or other higher-order sequence
words.

```factor
{ 2 0 4 } has-day-without-birds? .   ! => t
{ 3 8 1 5 } has-day-without-birds? . ! => f
```

## 4. Total birds since you started

Define `total` to return the sum of every count.

**Use recursion** rather than `sum`.

```factor
{ 4 0 9 0 5 } total .
! => 18
```

## 5. Busy days

A busy day is one with five or more birds. Define `busy-days` to
return the number of busy days.

**Use recursion** rather than `count`.

```factor
{ 4 5 0 0 6 } busy-days .
! => 2
```

## Source

### Created by

- @keiravillekode