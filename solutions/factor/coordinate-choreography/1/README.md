# Coordinate Choreography

Welcome to Coordinate Choreography on Exercism's Factor Track.
If you need help running the tests or submitting your code, check out `HELP.md`.
If you get stuck on the exercise, check out `HINTS.md`, but try and solve it without using those first :)

## Introduction

When a quotation needs to *remember* values from its surroundings —
what other languages call a *closure* — Factor uses two tools: the
`curry` word and the `'[ ]` *fry* syntax.

## `curry` — capturing one value

`curry` (in [`kernel`][kernel]) takes a value and a quotation and
returns a new quotation with that value baked in:

```
curry ( value quot -- newquot )
```

```factor
3 [ + ] curry .
! => [ 3 + ]

10 3 [ + ] curry call .
! => 13
```

Apply `curry` twice to capture two values:

```factor
2 3 [ + + ] curry curry .
! => [ 2 3 + + ]
```

## `compose` — joining two quotations

`compose` (in [`kernel`][kernel]) glues two quotations together:

```
compose ( quot1 quot2 -- quot )
```

```factor
[ 1 + ] [ 2 * ] compose .
! => [ 1 + 2 * ]

5 [ 1 + ] [ 2 * ] compose call .
! => 12
```

## Fry quotations — capturing several values

For more than one or two captures, chained `curry` calls become
hard to read. *Fry* uses `'[ … ]` with one or more `_` placeholders;
each `_` is replaced by a value taken off the data stack, in order:

```factor
2 3 '[ _ _ + + ] .
! => [ 2 3 + + ]
```

Both `curry` and fry *consume* their values from the stack the
moment the closure is built. The line above leaves nothing on the
stack and is a direct replacement for `[ + + ] curry curry`.

Placeholders are filled left-to-right with stack values
bottom-to-top: `2 3 '[ _ _ ]` is `[ 2 3 ]`, not `[ 3 2 ]`.

Fry also reaches *into* nested quotations, which lets you place the
captured values exactly where you want them:

```factor
2 '[ [ _ > ] filter ] { 1 2 3 4 5 } swap call( s -- s ) .
! => { 3 4 5 }
```

The `_` sits inside the inner `[ … ]`, but fry still fills it.

## `call` with a declared effect

When you ultimately run a stored quotation, declare its stack effect
on `call` so the compiler can type-check it:

```factor
{ 3 4 5 } [ first2 + ] call( p -- n ) .
! => 7

{ 3 4 5 } [ first ] call( p -- n ) .
! => 3
```

## Vector arithmetic

The [`math.vectors`][math.vectors] vocabulary combines two same-length
sequences element-wise. `v+` and `v*` add or multiply them; `vmax` and
`vmin` keep the larger or smaller of each component. Each gives back a
2-array:

```factor
{ 1 1 } { 3 4 } v+ .    ! => { 4 5 }
{ 2 5 } { 3 -1 } v* .   ! => { 6 -5 }
{ 1 9 } { 4 4 } vmax .  ! => { 4 9 }
{ 1 9 } { 4 4 } vmin .  ! => { 1 4 }
```

[kernel]: https://docs.factorcode.org/content/vocab-kernel.html
[math.vectors]: https://docs.factorcode.org/content/vocab-math.vectors.html

## Instructions

Your design team is moving from CSS transforms to Factor for some of
its layout work. To keep the rest of the team happy, you'll build
small, reusable transformations as quotations that take a 2D point
and return a 2D point.

A point is a 2-array `{ x y }`.

## 1. Translate the coordinates

Define `translate-2d` to take two values `dx` and `dy` off the stack
and return a quotation that translates a point by `(dx, dy)`.

```factor
{ 4 8 } 2 0 translate-2d call( p -- p' ) .
! => { 6 8 }
```

## 2. Scale the coordinates

Define `scale-2d` the same way, returning a quotation that scales a
point by `(sx, sy)`.

```factor
{ 6 -3 } 2 2 scale-2d call( p -- p' ) .
! => { 12 -6 }
```

## 3. Compose two transformations

Define `compose-transformations` to take two transformation
quotations `f` and `g` and return a single quotation that applies
`f` first and then `g`.

```factor
{ 0 1 } 2 0 translate-2d 2 2 scale-2d compose-transformations
call( p -- p' ) .
! => { 4 2 }
```

## 4. Apply a transformation

Define `apply-transformation` to take a point and a transformation
quotation off the stack and return the transformed point.

```factor
{ 4 8 } 2 0 translate-2d apply-transformation .
! => { 6 8 }
```

## 5. Transform many points at once

Define `transform-points` to take an array of points and a
transformation quotation, and return the array of transformed points.

```factor
{ { 0 0 } { 1 1 } { 2 2 } } 1 0 translate-2d transform-points .
! => { { 1 0 } { 2 1 } { 3 2 } }
```

## Source

### Created by

- @keiravillekode