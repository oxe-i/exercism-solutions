# Joiner's Journey

Welcome to Joiner's Journey on Exercism's Factor Track.
If you need help running the tests or submitting your code, check out `HELP.md`.
If you get stuck on the exercise, check out `HINTS.md`, but try and solve it without using those first :)

## Introduction

Almost every Factor program is a sequence of words consuming and
producing values on the *data stack*. When inputs and outputs line
up neatly, the code reads left-to-right with no fuss. When they
don't, you reach for *shuffle words* — and the code gets noisy fast.

This exercise walks you through Factor's standard fix: combinators.

## Shuffle words

The most common shuffle words live in [`kernel`][kernel]:

```
dup    ( x -- x x )
dupd   ( x y -- x x y )
drop   ( x -- )
swap   ( x y -- y x )
swapd  ( x y z -- y x z )
over   ( x y -- x y x )
pick   ( x y z -- x y z x )
rot    ( x y z -- y z x )
-rot   ( x y z -- z x y )
rotd   ( w x y z -- w y z x )
spin   ( x y z -- z y x )
nip    ( x y -- y )
tuck   ( x y -- y x y )

2dup   ( x y -- x y x y )
3dup   ( x y z -- x y z x y z )
4dup   ( w x y z -- w x y z w x y z )
2drop  ( x y -- )
3drop  ( x y z -- )
4drop  ( w x y z -- )
2nip   ( x y z -- z )
2swap  ( x y z w -- z w x y )
```

You'll already have used `dup` and `swap`. `over` makes a copy of
the *second* element from the top — handy when the same input
needs to feed two computations:

```factor
! Sum a number with twice itself: x + 2*x
: triple ( x -- 3x ) dup 2 * + ;
```

That's fine for one use. But strung together, sequences of `dup`,
`swap`, `over`, `rot` quickly become unreadable.

## `keep` — preserve the input

`keep` (in [`kernel`][kernel]) calls a quotation on the top of the
stack but leaves the original value above the result:

```
keep ( x quot: ( x -- y ) -- y x )
```

```factor
5 [ 2 * ] keep .s
! => 10
! => 5
```

That replaces a `dup`-followed-by-something-then-shuffle
pattern: anywhere you'd write `dup something swap`, you can
just say `[ something ] keep`.

## `bi` — two functions of one input

`bi` (in [`kernel`][kernel]) applies *two* quotations to the same
value, leaving both results on the stack:

```
bi ( x q1 q2 -- r1 r2 )
```

```factor
4 [ sq ] [ neg ] bi .s
! => 16
! => -4
```

Without `bi` you'd write `dup sq swap neg` — readable enough for
two operations, gnarly for three.

## `tri` and `cleave` — many functions of one input

`tri` extends `bi` to three quotations:

```
tri ( x q1 q2 q3 -- r1 r2 r3 )
```

`cleave` (in [`combinators`][combinators]) is the same idea for an
*array* of any number of quotations:

```factor
4 { [ ] [ sq ] [ neg ] } cleave .s
! => 4
! => 16
! => -4
```

The empty quotation `[ ]` acts as the identity — useful when one of
the slots in the cut card should be the input itself.

## `dip` and `2dip` — operate underneath

`dip` (in [`kernel`][kernel]) calls a quotation on the values *under*
the top of stack, leaving the top untouched. `2dip` does the same
but protects the top *two* values:

```
dip  ( x   quot -- x   )
2dip ( x y quot -- x y )
```

```factor
9 10 11 [ + ] dip .s
! => 19      (9 + 10)
! => 11      (the protected top, restored)

9 10 11 12 [ + ] 2dip .s
! => 19      (9 + 10)
! => 11      (the protected y, originally 11)
! => 12      (the protected x, originally 12)
```

Here `dip` hid `11`, ran `9 10 +`, and put `11` back on top.
`2dip` hid `11 12`, ran `9 10 +` underneath, then restored
`11 12`.

`dip` is the right tool when the natural argument order leaves the
"pass-through" value on top of the stack. Reach for it instead of
the `swap … swap` sandwich.

## `bi@` — same operation on two values

`bi@` (in [`kernel`][kernel]) applies one quotation to two stack
values:

```
bi@ ( x y quot -- r1 r2 )
```

```factor
3 4 [ sq ] bi@ .s
! => 9
! => 16
```

## `bi*` — different operations on two values

`bi*` (in [`kernel`][kernel]) applies *different* quotations to the
two stack values — the first quotation to the lower value, the
second to the top:

```
bi* ( x y q1 q2 -- r1 r2 )
```

```factor
3 4 [ sq ] [ neg ] bi* .s
! => 9
! => -4
```

Reach for `bi@` when both values get the same treatment, and for
`bi*` when each needs its own.

## `tri*` — different operations on three values

`tri*` (in [`combinators`][combinators]) extends `bi*` to three
values and three quotations, applying each quotation to one value
in order:

```
tri* ( x y z q1 q2 q3 -- r1 r2 r3 )
```

```factor
1 2 3 [ sq ] [ neg ] [ 10 * ] tri* .s
! => 1
! => -2
! => 30
```

[kernel]: https://docs.factorcode.org/content/vocab-kernel.html
[combinators]: https://docs.factorcode.org/content/vocab-combinators.html

## Instructions

You're apprenticing at a small furniture workshop. The master
carpenter's tablet runs Factor and tracks the cut list — every
board that lands on the workbench gets measured up with a few
derived values before the first cut is made.

The previous apprentice left the till code in a jungle of `dup`,
`over`, `swap`, and `rot`. Your job is to rewrite five small words
using *combinators*.

Each board enters the workflow with just its raw length (cm) on
the stack.

## 1. Add the kerf allowance

Saw blades remove a thin strip of wood from every cut — the *kerf*.
The shop budgets 2% extra length on every board to absorb it.

Define `with-kerf` to take a length and return the length plus its
2% kerf allowance.

```factor
100 with-kerf .
! => 102
```

## 2. Compute kerf and finish allowances

After cutting comes finishing — sanding and planing — which removes
another 5% of the original length.

Define `kerf-and-finish` to return *both* allowances side by side
(kerf below, finish on top).

```factor
100 kerf-and-finish .s
! => 2
! => 5
```

## 3. Build the cut card

Every board the master cuts gets a small card stuck on it that lists
the raw length, the kerf allowance, and the finish allowance — three
numbers, in that order.

Define `cut-card` to return all three.

```factor
100 cut-card .s
! => 100
! => 2
! => 5
```

## 4. Per-piece length

The shop also receives bulk *bolts* of timber that need dividing
into equal pieces. The kerf allowance is added to the bolt's length
once, then the result is divided by the number of pieces.

Define `per-piece` to take the bolt's length and the number of
pieces — the piece count is on top of the stack — and return the
per-piece length.

```factor
100 2 per-piece .
! => 51

100 4 per-piece .
! => 25+1/2
```

## 5. Compare two bolts

Sometimes the master is choosing between two bolts at the lumber
yard and wants to compare their kerf allowances at a glance.

Define `compare-bolts` to take two lengths off the stack and return
the kerf allowance for each (in the same order).

```factor
50 100 compare-bolts .s
! => 1
! => 2
```

## Source

### Created by

- @keiravillekode