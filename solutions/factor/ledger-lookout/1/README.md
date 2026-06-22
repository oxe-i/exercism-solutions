# Ledger Lookout

Welcome to Ledger Lookout on Exercism's Factor Track.
If you need help running the tests or submitting your code, check out `HELP.md`.
If you get stuck on the exercise, check out `HINTS.md`, but try and solve it without using those first :)

## Introduction

You already know the basics: character classes like `\d` and `[A-Z]`,
quantifiers like `{4}` and `+`, and the words `matches?`,
`all-matching-subseqs`, and `re-replace`. This exercise adds the parts
of regular expressions that describe *structure* and *context*. They
live in the same [`regexp`][regexp] vocabulary, written with the same
`R/ /` literal.

## Anchors

Anchors match a *position* rather than a character:

```
^    ! the start of the string
$    ! the end of the string
\b   ! a word boundary
```

Because `$` means the end of the string, write `\$` when you mean a
literal dollar sign.

A *word boundary* (`\b`) is the spot where a *word character* meets a
non-word one. Word characters are letters, digits, and the underscore;
everything else — spaces, punctuation, and the two ends of the
string — counts as a boundary. So `\bcat\b` matches `cat` only when it
stands on its own:

```factor
USING: regexp ;

"cat nap" R/ \bcat\b/ re-contains? .   ! => t
"scatter" R/ \bcat\b/ re-contains? .   ! => f   (cat sits inside a word)
```

## Grouping and alternation

Round brackets `( )` group part of a pattern so that a quantifier — or
a `|` ("this **or** that") — applies to the whole group:

```factor
USING: regexp ;

"abab" R/ (ab)+/ matches? .                ! => t   (+ applies to "ab")
"dog"  R/ cat|dog/ matches? .              ! => t   (either word)
"$100.50" R/ \$\d+(\.\d{2})?/ matches? .   ! => t
"$100"    R/ \$\d+(\.\d{2})?/ matches? .   ! => t   (the group is optional)
```

The last pattern reads "a dollar sign, one or more digits, then an
*optional* group of a dot and two digits".

> Note: in Factor a group only *structures* the pattern. Unlike some
> regex tools, you cannot pull back out the text a group matched —
> there is no capture-group extraction, and back-references like `\1`
> are not supported. To pick text out *around* a landmark, use
> lookaround instead (below).

## Lookaround — match by context, without consuming it

A *lookaround* checks what comes just before or just after the current
spot **without** making those characters part of the match. It is
"zero-width": what it tests is not included in the result.

```
(?=...)    ! lookahead:           ... must follow
(?!...)    ! negative lookahead:  ... must NOT follow
(?<=...)   ! lookbehind:          ... must come before
(?<!...)   ! negative lookbehind: ... must NOT come before
```

Lookaround is *selective* — the same characters match or not depending
on what sits beside them. A plain `\d+` grabs every number; the lookbehind
and lookahead keep only those with the right neighbour:

```factor
USING: regexp ;

"3 for $10 or 10 for $30" R/ \d+/ all-matching-subseqs .
! => { "3" "10" "10" "30" }   (every number)

"3 for $10 or 10 for $30" R/ (?<=\$)\d+/ all-matching-subseqs .
! => { "10" "30" }            (only the prices — the bare 3 and 10 drop)

"buy 2 at 15% off, 4 at 30% off" R/ \d+(?=%)/ all-matching-subseqs .
! => { "15" "30" }            (only the discounts — the bare 2 and 4 drop)
```

## Options

Add a letter after the closing `/` to change how the whole pattern
behaves. `i` makes it case-insensitive:

```factor
USING: regexp ;

"REFUND"  R/ refund/i matches? .       ! => t
"Refund"  R/ refund/i matches? .       ! => t
```

## Transforming each match

`all-matching-subseqs` hands you the matched text. `map-matches` goes a
step further — it runs a quotation on *each* match and collects the
results. The quotation receives the match's `start` index, its `end`
index, and the whole string; `subseq` turns those three into the
matched text, which you then transform:

```
map-matches ( string regexp quot: ( start end string -- obj ) -- seq )
```

```factor
USING: math regexp sequences ;

"a1 b22 c333" R/ \d+/ [ subseq length ] map-matches .
! => { 1 2 3 }     (the length of each run of digits)
```

Its side-effect-only cousin, [`each-match`][each-match], runs a
quotation on each match without collecting anything.

[regexp]: https://docs.factorcode.org/content/vocab-regexp.html
[each-match]: https://docs.factorcode.org/content/word-each-match%2Cregexp.html

## Instructions

You keep the books for a small company, and each day's transactions
arrive as untidy lines of text. You'll use regular expressions to
validate amounts, pull figures out by the symbol that marks them, and
flag lines that need a closer look.

## 1. Validate an amount

A well-formed amount is a `$`, one or more digits, and an *optional*
cents part of a dot followed by exactly two digits — `$100` or
`$100.50`, but not `$100.5`. Define `valid-amount?`, returning `t`
when the *whole* string is a well-formed amount.

```factor
"$100.50" valid-amount? .   ! => t
"$100"    valid-amount? .   ! => t
"$100.5"  valid-amount? .   ! => f
```

## 2. Pull out the dollar figures

Define `dollar-amounts`, returning every number that directly follows
a `$` in the line — the digits only, without the `$` — in order.

```factor
"spent $100 and $25 today" dollar-amounts .
! => { "100" "25" }
```

## 3. Pull out the percentages

Define `percentages`, returning every number that is immediately
followed by a `%`.

```factor
"up 5% then down 12%" percentages .
! => { "5" "12" }
```

## 4. Flag a line

Define `flagged?`, returning `t` when the line mentions `refund` or
`chargeback` in any mix of upper- and lower-case.

```factor
"Issued a REFUND today" flagged? .   ! => t
"a normal sale"         flagged? .   ! => f
```

## Source

### Created by

- @keiravillekode