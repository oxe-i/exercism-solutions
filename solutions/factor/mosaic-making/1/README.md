# Mosaic Making

Welcome to Mosaic Making on Exercism's Factor Track.
If you need help running the tests or submitting your code, check out `HELP.md`.
If you get stuck on the exercise, check out `HINTS.md`, but try and solve it without using those first :)

## Introduction

Arrays are Factor's fixed-length sequences: you can change the
elements, but not the length. You already know how to write a literal
array — `{ … }` — and how to slice and aggregate one. This exercise
covers the small toolkit that comes up when you build arrays from
values on the stack and then look up or rearrange their contents.

## Building from the stack

`1array`, `2array`, `3array`, and `4array` (in [`arrays`][arrays])
take 1, 2, 3, or 4 values off the top of the stack and bundle them:

```
1array ( a       -- { a }       )
2array ( a b     -- { a b }     )
3array ( a b c   -- { a b c }   )
4array ( a b c d -- { a b c d } )
```

```factor
42 1array .                ! => { 42 }
3 4 2array .               ! => { 3 4 }
"x" "y" "z" 3array .       ! => { "x" "y" "z" }
1 2 3 4 4array .           ! => { 1 2 3 4 }
```

## Joining

`concat` (in [`sequences`][sequences]) takes a sequence whose
elements are themselves sequences and flattens them by one level.
`join` does the same with a separator inserted between each pair:

```
concat ( seqs     -- seq )
join   ( seqs sep -- seq )
```

```factor
{ { 1 2 } { 3 4 } { 5 } } concat .
! => { 1 2 3 4 5 }

{ "alpha" "beta" "gamma" } ", " join .
! => "alpha, beta, gamma"
```

## Reversing

`reverse` returns a new sequence with the elements in opposite
order:

```
reverse ( seq -- newseq )
```

```factor
{ 1 2 3 4 } reverse .   ! => { 4 3 2 1 }
```

## Is it an array?

`array?` (in [`arrays`][arrays]) is the type predicate. It's
true for any value built by `<array>`, `1array`/`2array`/...,
or an array literal `{ … }`, and false for everything else
(including vectors, strings, and other sequences):

```
array? ( obj -- ? )
```

```factor
{ 1 2 3 } array? .         ! => t
"hello" array? .           ! => f
V{ 1 2 3 } array? .        ! => f
```

## Looking up

`index` returns the position of the first element equal to the
input value, or `f` if it isn't present. `member?` returns just a
boolean. Both take the **element first** and the **sequence
second**. `members` (in [`sets`][sets]) returns the *unique*
elements of a sequence — the deduplication operation —
and `all-unique?` (also in `sets`) tests whether the sequence
already has no duplicates:

```
index       ( elt seq -- i/f )
member?     ( elt seq -- ? )
members     ( seq     -- uniques )
all-unique? ( seq     -- ? )
```

```factor
"b" { "a" "b" "c" } index .       ! => 1
"z" { "a" "b" "c" } index .       ! => f
"b" { "a" "b" "c" } member? .     ! => t
"z" { "a" "b" "c" } member? .     ! => f
{ 1 2 3 2 1 } members .           ! => { 1 2 3 }
{ 1 2 3 } all-unique? .           ! => t
{ 1 2 1 } all-unique? .           ! => f
```

[arrays]: https://docs.factorcode.org/content/vocab-arrays.html
[sequences]: https://docs.factorcode.org/content/vocab-sequences.html
[sets]: https://docs.factorcode.org/content/vocab-sets.html

## Instructions

You're volunteering at the community arts centre, where a long
ceramic-tile mosaic is going up over the front entrance. The
design team has laid the work out **row by row**: each row is an
array of tile colours, and the whole mosaic is an array of rows.

As volunteers cut, place, and rearrange tiles, you're writing
small reusable words to build, combine, and look up pieces of the
design.

## 1. A single-tile strip

Define `tile-strip` to take a colour and return a 1-element row
holding just that colour.

```factor
"sky-blue" tile-strip .
! => { "sky-blue" }
```

## 2. A row of three tiles

Define `row-of-three` to take three colours off the stack and
return a 3-element row.

```factor
"red" "white" "blue" row-of-three .
! => { "red" "white" "blue" }
```

## 3. Combine the rows into a flat tile list

The design team needs to sanity-check colour totals across all
rows of the mosaic. Define `combine-rows` to take an array of
rows and return a single sequence of every tile in order.

```factor
{ { "red" "white" } { "blue" "red" } } combine-rows .
! => { "red" "white" "blue" "red" }
```

## 4. Mirror a row

For symmetric panels the team mirrors a row before placing the
copy on the opposite side. Define `mirror-row` to return a row
in reverse order.

```factor
{ "red" "white" "blue" } mirror-row .
! => { "blue" "white" "red" }
```

## 5. Where is this colour in the row?

Define `tile-position` to take a row and a colour and return the
index (0-based) of the first tile with that colour in the row.
If the colour isn't present, return `f`.

```factor
{ "red" "white" "blue" } "white" tile-position .
! => 1

{ "red" "white" "blue" } "green" tile-position .
! => f
```

## 6. Does this row contain the colour?

Define `has-colour?` to take a row and a colour and return `t`
if the colour appears anywhere in the row, otherwise `f`.

```factor
{ "red" "white" "blue" } "white" has-colour? .
! => t

{ "red" "white" "blue" } "green" has-colour? .
! => f
```

## Source

### Created by

- @keiravillekode