# Cars, Assemble!

Welcome to Cars, Assemble! on Exercism's Factor Track.
If you need help running the tests or submitting your code, check out `HELP.md`.
If you get stuck on the exercise, check out `HINTS.md`, but try and solve it without using those first :)

## Introduction

This exercise introduces conditionals — choosing between two or more
courses of action based on a value. It builds on the booleans you met
in [Annalyn's Infiltration][annalyns] and the integer arithmetic from
[Currency Conversion][currency-conversion].

## Comparison words

These all live in [`math`][math] (and [`kernel`][kernel] for `=`):

```
=  ( x y -- ? )    ! equal
<  ( x y -- ? )    ! less than
<= ( x y -- ? )    ! less than or equal
>  ( x y -- ? )    ! greater than
>= ( x y -- ? )    ! greater than or equal
```

```factor
3 3 = .     ! => t
2 3 < .     ! => t
3 3 <= .    ! => t
3 4 = not . ! => t    (inequality: combine = with not)
```

`zero?` (in [`math`][math]) is a shorthand for the common `0 =` test —
it consumes the number and pushes whether it was zero:

```
zero? ( n -- ? )    ! t when n is 0
```

## Range checks

`between?` (in [`math.order`][math.order]) tests whether a value
falls within an inclusive range. It's handy when an action depends
on which band a number lands in:

```
between? ( x lo hi -- ? )    ! lo <= x <= hi (inclusive)
```

```factor
5 1 10 between? .    ! => t
0 1 10 between? .    ! => f
10 1 10 between? .   ! => t   (inclusive at both ends)
```

You'll often see it as a `cond` predicate — `dup 1 4 between?` —
to pick a branch by range rather than by a single value.

## `if`, `when`, `unless`

`if` (in [`kernel`][kernel]) takes a boolean and two quotations. It
runs the first quotation when the boolean is truthy and the second
when it is falsy:

```
if ( ? then-quot else-quot -- )
```

```factor
: abs ( x -- y ) dup 0 < [ neg ] [ ] if ;
```

`when` runs its quotation only when the boolean is truthy; `unless`
only when it is falsy:

```
when   ( ? quot -- )
unless ( ? quot -- )
```

## `if*`, `when*`, and `unless*`

Three kernel variants treat the boolean as a *value* worth keeping
when it's truthy — useful when a word returns "the thing, or `f`":

```
if*     ( ? true false -- )    ! truthy: true is called WITH ? on stack
when*   ( ? true       -- )    ! truthy: true is called WITH ? on stack
unless* ( ? false      -- )    ! falsy: false runs and pushes a default
```

`if*` is the two-branch form. The truthy branch is called with
the value still on the stack; the falsy branch is called
without it:

```factor
42 [ ] [ "nothing" ] if* .   ! prints 42
f  [ ] [ "nothing" ] if* .   ! prints "nothing"
```

`unless*` is the canonical "value or default" idiom. If the value
is truthy, it's left alone; if it's `f`, the value is dropped and
the quotation runs to push a substitute:

```factor
"hello" [ "anonymous" ] unless* .   ! => "hello"
f       [ "anonymous" ] unless* .   ! => "anonymous"
```

`when*` is the one-branch form of `if*`: it runs its quotation —
with the value still on the stack — only when the value is truthy,
and simply drops the value when it's `f`. Reach for it to fold a
"the thing, or `f`" result into a running value without bothering
to handle the `f` case:

```factor
0 41 [ + ] when* .   ! => 41   (truthy: 41 added to the running total)
0 f  [ + ] when* .   ! => 0    (falsy: f dropped, total left untouched)
```

## `cond`

When you have several alternative actions to choose between, `cond`
(in [`combinators`][combinators]) is the natural fit. It takes an
array of `{ predicate body }` pairs and runs the body of the first
predicate that yields a truthy value:

```factor
USING: combinators ;

: classify ( n -- label )
    {
        { [ dup 0 <  ] [ drop "negative" ] }
        { [ dup 0 =  ] [ drop "zero"     ] }
        [ drop "positive" ]
    } cond ;
```

A few details worth noting:

- The pairs are tried in order. The first match wins.
- An entry without a predicate (just a single quotation) at the end
  acts as the default.
- Each predicate inspects the input but should leave the data stack
  the way it found it — `dup ... <test>` is the usual idiom.
- The body of the chosen pair receives the same stack the predicate
  saw, so it usually starts by `drop`ping the input and pushing the
  result.

[annalyns]: https://exercism.org/tracks/factor/exercises/annalyns-infiltration
[currency-conversion]: https://exercism.org/tracks/factor/exercises/currency-conversion
[math]: https://docs.factorcode.org/content/vocab-math.html
[math.order]: https://docs.factorcode.org/content/vocab-math.order.html
[kernel]: https://docs.factorcode.org/content/vocab-kernel.html
[combinators]: https://docs.factorcode.org/content/vocab-combinators.html

## Instructions

In this exercise you'll be writing code to analyze the production of
an assembly line in a car factory. The assembly line's speed can range
from `0` (off) to `10` (maximum).

At its lowest non-zero speed (`1`), `221` cars are produced each hour.
The production increases linearly with the speed, so at speed `4` the
line produces `4 * 221 = 884` cars per hour. However, higher speeds
increase the likelihood that faulty cars are produced, which then
have to be discarded.

You have four tasks. Each takes a single integer parameter — the
speed of the assembly line — off the stack.

## 1. Report whether the line is running

Define `production-status` to return `"stopped"` when the speed is `0`
and `"running"` for any other speed:

```factor
0 production-status .
! => "stopped"
3 production-status .
! => "running"
```

## 2. Calculate the success rate

Define `success-rate` to return the probability of an item being
produced without error:

- `0`: `0.0`
- `1` to `4`: `1.0`
- `5` to `8`: `0.9`
- `9`: `0.8`
- `10`: `0.77`

```factor
10 success-rate .
! => 0.77
```

## 3. Calculate the production rate per hour

Define `production-rate-per-hour` to return the assembly line's
production rate per hour, taking the success rate into account.

You'll need to define `base-speed` first, the constant `221`.

```factor
6 production-rate-per-hour .
! => 1193.4
```

The value returned is floating-point.

## 4. Calculate the number of working items produced per minute

Define `working-items-per-minute` to return how many working cars are
produced per minute. The result is an integer — partial cars are not
counted.

```factor
6 working-items-per-minute .
! => 19
```

## Source

### Created by

- @keiravillekode