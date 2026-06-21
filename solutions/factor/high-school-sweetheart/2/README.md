# High School Sweetheart

Welcome to High School Sweetheart on Exercism's Factor Track.
If you need help running the tests or submitting your code, check out `HELP.md`.
If you get stuck on the exercise, check out `HINTS.md`, but try and solve it without using those first :)

## Introduction

In Factor, you combine words just by writing them one after another —
the order you write them in *is* how they join up. (Programmers call
this *function composition*.) A word's body is itself a sequence of
words: each one consumes some
values from the stack and pushes its result, and the next word picks
up where the previous left off. So defining

```factor
! DOCTEST: SKIP   (cleanupname is hypothetical here — the exercise's job)
: firstletter ( name -- letter ) cleanupname first 1string ;
```

already *is* the composition of `cleanupname`, `first`, and `1string`.

This exercise also introduces **quotations** — a piece of code you can
store as a value and run later, instead of running it on the spot.

## Quotations

A quotation is a piece of code wrapped in square brackets. It doesn't
run when written; it sits on the stack as a value:

```factor
[ 2 * ] .       ! => [ 2 * ]
```

`call` runs a quotation:

```factor
3 [ 2 * ] call .    ! => 6
```

You write a quotation when you need to pass code as data: to be run
later, or to be passed to a *combinator* — a word that takes a
quotation as input.

## `compose`

`compose ( quot1 quot2 -- combined )` glues two quotations into one,
running them in the order written:

```factor
[ 2 * ] [ 1 + ] compose .    ! => [ 2 * 1 + ]
```

You'll usually find that defining a small word with `:` ... `;` reads
better than `compose`, but `compose` is handy when you need to build
quotations on the fly. When the building blocks aren't already
quotations, `>quotation ( seq -- quot )` (from
[`quotations`][quotations]) turns a sequence of values and word
references into a callable quotation:

```factor
USING: quotations sequences ;

{ [ 1 ] [ 2 + ] [ 3 * ] } concat >quotation call .   ! => 9
```

## Applying one quotation to two inputs

`bi@ ( x y quot -- ... )` runs the quotation on `x` and again on `y`,
leaving both results on the stack:

```factor
3 4 [ 2 * ] bi@ .s
! => 6
! => 8
```

The exercise's `couple` task takes two names; `bi@` is the natural way
to apply `initial` to each.

## A few string words

The exercise needs a handful of small string words, drawn from three
vocabularies — [`sequences`][sequences], [`ascii`][ascii], and
[`strings`][strings]:

- `replace ( seq old new -- new-seq )` (in `sequences`) — substring
  replace.
- `[ blank? ] trim` (`trim` in `sequences`, `blank?` in `ascii`) — drop
  leading/trailing whitespace.
- `1string ( char -- str )` (in `strings`) — wrap a single character as
  a string.
- `>upper ( str -- upper )` (in `ascii`) — uppercase a string.
- `append ( s1 s2 -- s )` (in `sequences`) — concatenate two strings.
- `prepend ( s1 s2 -- s )` (in `sequences`) — concatenate `s2` then `s1`
  (`append` with its inputs in the other order).
- `glue ( s1 s2 sep -- s )` (in `sequences`) — concatenate two strings
  with a separator between them.
- `surround ( seq pre post -- new )` (in `sequences`) — wrap a string
  with a prefix and a suffix.

Unicode characters can be written as `\u{XXXX}` inside a string, where
`XXXX` is the codepoint in hex. The heart `\u{2764}` (❤) appears in
this exercise.

## Formatted output

When `append`/`glue`/`surround` aren't expressive enough,
[`formatting`][formatting] provides the printf-style `sprintf`:

```
sprintf ( inputs... format-string -- str )
```

`%s` interpolates a string, `%d` an integer, `%f` a float;
optional width, precision, and padding modifiers come between
`%` and the type letter:

```factor
USING: formatting ;

"Alice" "Bob" "%s & %s" sprintf .   ! => "Alice & Bob"
3.14159 "%.2f" sprintf .             ! => "3.14"
42 "%05d" sprintf .                  ! => "00042"
```

For round-tripping between numbers and strings,
[`math.parser`][math.parser] has `number>string` and
`string>number`:

```factor
USING: math.parser ;

42 number>string .       ! => "42"
"3.14" string>number .   ! => 3.14
```

[sequences]: https://docs.factorcode.org/content/vocab-sequences.html
[ascii]: https://docs.factorcode.org/content/vocab-ascii.html
[strings]: https://docs.factorcode.org/content/vocab-strings.html
[formatting]: https://docs.factorcode.org/content/vocab-formatting.html
[math.parser]: https://docs.factorcode.org/content/vocab-math.parser.html
[quotations]: https://docs.factorcode.org/content/vocab-quotations.html

## Instructions

You are going to help high school sweethearts profess their love on
social media by generating a unicode heart with their initials:

```
❤ J.  +  M. ❤
```

## 1. Clean up the name

Define `cleanupname` taking a name off the stack. Replace every `-`
with a space, then strip leading and trailing whitespace.

```factor
"Jane-Ann" cleanupname .
! => "Jane Ann"
```

## 2. Get the name's first letter

Define `firstletter` taking a name. Reuse `cleanupname` from the
previous task, then take the first character of the result and return
it as a one-character string.

```factor
"Jane" firstletter .
! => "J"
```

## 3. Format the first letter as an initial

Define `initial` taking a name. Reuse `firstletter` from the previous
task, uppercase it, then append a `.`.

```factor
"Robert" initial .
! => "R."
```

## 4. Put the initials inside of the heart

Define `couple` taking two names off the stack. Reuse `initial` from
the previous task on each name, then assemble the result:

```factor
"Blake Miller" "Riley Lewis" couple .
! => "❤ B.  +  R. ❤"
```

## Source

### Created by

- @keiravillekode