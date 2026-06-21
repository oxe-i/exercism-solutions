# Log Levels

Welcome to Log Levels on Exercism's Factor Track.
If you need help running the tests or submitting your code, check out `HELP.md`.
If you get stuck on the exercise, check out `HINTS.md`, but try and solve it without using those first :)

## Introduction

A string in Factor is a sequence of characters. Most words from the
[`sequences`][sequences] vocabulary work on strings, in addition to the
dedicated string-handling words in [`splitting`][splitting],
[`ascii`][ascii], and friends.

## String literals

Strings are written in double quotes. The usual escapes are supported
— `\n`, `\t`, `\r`, `\\`, `\"`:

```factor
"hello, world" .                 ! => "hello, world"
"first\nsecond" print            ! prints two lines
```

## Length and indexing

Because a string is a sequence, the [`sequences`][sequences] words
`length` and `nth` work on it directly.

`length` returns the number of characters:

```factor
"hello" length .    ! => 5
```

`nth` takes a 0-based index and the sequence, and returns the
element at that position. For a string the element is a
*character* — a code point (an integer), not a one-character
substring:

```factor
0 "hello" nth .     ! => 104   (CHAR: h)
4 "hello" nth .     ! => 111   (CHAR: o)
```

## From a character back to a string

To turn a single code point into a one-character string, use
`1string ( char -- str )` from the [`strings`][strings] vocabulary.
`CHAR:` is the parser-time form of a literal code point:

```factor
CHAR: A 1string .                ! => "A"
0 "hello" nth 1string .          ! => "h"
```

## Splitting

The [`splitting`][splitting] vocabulary cuts a string into pieces.

`split1` cuts on the *first* occurrence of a separator and returns
both halves:

```
split1 ( seq subseq -- before after )
```

```factor
"foo: bar" ": " split1 .s
! => "foo"
! => "bar"
```

`split` cuts on *any* of the characters in a separator set, possibly
producing empty pieces:

```factor
"[ERROR]: Stack overflow" "[]" split .
! => { "" "ERROR" ": Stack overflow" }
```

`harvest` (in [`sequences`][sequences]) drops the empty pieces:

```factor
"[ERROR]: Stack overflow" "[]" split harvest .
! => { "ERROR" ": Stack overflow" }
```

## Picking out a piece

Once a string is split into an array of pieces, `first`,
`second`, `third`, and `fourth` (in [`sequences`][sequences])
return the piece at that position:

```factor
"apple,bee,carrot,duck" "," split first .    ! => "apple"
"apple,bee,carrot,duck" "," split second .   ! => "bee"
"apple,bee,carrot,duck" "," split third .    ! => "carrot"
"apple,bee,carrot,duck" "," split fourth .   ! => "duck"
```

When you want all the leading pieces on the stack at once,
`first2` and `first3` unpack two or three of them in one step:

```factor
"apple,bee,carrot,duck" "," split first2 .s
! => "apple"
! => "bee"

"apple,bee,carrot,duck" "," split first3 .s
! => "apple"
! => "bee"
! => "carrot"
```

On a string itself, `first` returns the first **character** — a
code point — rather than a substring:

```factor
"hello" first .                         ! => 104   (CHAR: h)
```

## Trimming

`[ blank? ] trim` (from [`sequences`][sequences], with `blank?` from
the [`ascii`][ascii] vocabulary) removes leading and trailing whitespace:

```factor
"  Disk full \r\n" [ blank? ] trim .
! => "Disk full"
```

## Case conversion

`>lower` and `>upper` (from [`ascii`][ascii]) return a new string
with the case changed:

```factor
"WARNING" >lower .    ! => "warning"
"hello" >upper .      ! => "HELLO"
```

## Joining

Two [`sequences`][sequences] words assemble strings:

`surround` wraps a string with a prefix and a suffix:

```
surround ( seq pre post -- new-seq )
```

```factor
"warning" "(" ")" surround .    ! => "(warning)"
```

`glue` joins two strings with a separator between them:

```
glue ( s1 s2 sep -- s )
```

```factor
"Disk full" "(error)" " " glue .    ! => "Disk full (error)"
```

[splitting]: https://docs.factorcode.org/content/vocab-splitting.html
[sequences]: https://docs.factorcode.org/content/vocab-sequences.html
[ascii]: https://docs.factorcode.org/content/vocab-ascii.html
[strings]: https://docs.factorcode.org/content/vocab-strings.html

## Instructions

In this exercise you'll be processing log lines.

Each log line is a string formatted as `"[<LEVEL>]: <MESSAGE>"`.

There are three log levels: `INFO`, `WARNING`, and `ERROR`.

You have three tasks. Each takes a single log line off the stack.

## 1. Get message from a log line

Define `message` to return the log line's message. Any leading or
trailing whitespace should be removed.

```factor
"[ERROR]: Invalid operation" message .
! => "Invalid operation"

"[WARNING]:  Disk almost full\r\n" message .
! => "Disk almost full"
```

## 2. Get log level from a log line

Define `log-level` to return the log line's level, lowercased.

```factor
"[ERROR]: Invalid operation" log-level .
! => "error"
```

## 3. Reformat a log line

Define `reformat` to put the message first and the lowercase log level
in parentheses after it.

```factor
"[INFO]: Operation completed" reformat .
! => "Operation completed (info)"
```

----

***Note:*** All strings in this exercise are ASCII. Later exercises
will tackle Unicode-aware string handling.

## Source

### Created by

- @keiravillekode