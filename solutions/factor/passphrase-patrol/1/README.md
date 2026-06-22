# Passphrase Patrol

Welcome to Passphrase Patrol on Exercism's Factor Track.
If you need help running the tests or submitting your code, check out `HELP.md`.
If you get stuck on the exercise, check out `HINTS.md`, but try and solve it without using those first :)

## Introduction

A *regular expression* (regex) is a small pattern that describes what
some text should look like. Instead of checking a string character by
character yourself, you write the shape you want once and let Factor do
the matching. Factor's regex tools live in the [`regexp`][regexp]
vocabulary.

## Writing a pattern

In Factor you write a regex between `R/ ` and `/`:

```factor
R/ cat/      ! the pattern that matches the letters c, a, t
```

Most characters in a pattern just mean themselves — `R/ cat/` matches
the text `cat`. The power comes from a few special pieces that stand
for *kinds* of characters or *how many* of them.

### Character classes — "one character from a set"

```
\d        ! any digit, 0–9
\D        ! any NON-digit (the opposite of \d)
\s        ! any space, tab, or newline
\S        ! any NON-space character (the opposite of \s)
\w        ! a "word" character: a letter, a digit, or an underscore
\W        ! any NON-word character (the opposite of \w)
[A-Z]     ! any one capital letter A to Z
[a-z]     ! any one lowercase letter
[0-9]     ! any one digit (same as \d)
.         ! any single character at all
```

A class matches exactly *one* character. `[A-Z]` matches `Q` but not
`QQ`.

### Quantifiers — "how many"

Put one of these *after* a piece to say how many times it may repeat:

```
{4}       ! exactly 4 times
{2,5}     ! between 2 and 5 times
+         ! one or more
*         ! zero or more
?         ! zero or one (optional)
```

So `\d{4}` means four digits in a row, and `[A-Z]+` means one or more
capital letters. Putting it together, `R/ [A-Z]+-\d+/` describes "one
or more capitals, a dash, then one or more digits" — text like
`SALE-2024`. The `-` here is an ordinary character: outside of `[ ]` a
dash just matches a dash (inside a class, as in `[A-Z]`, it marks a
range).

## Matching a whole string

`matches?` answers "does this *entire* string fit the pattern?" — the
pattern has to account for every character, start to end:

```
matches? ( string regexp -- ? )
```

```factor
USING: regexp ;

"SALE-2024"     R/ [A-Z]+-\d+/ matches? .   ! => t
"GET SALE-2024" R/ [A-Z]+-\d+/ matches? .   ! => f   (extra text before)
"SALE-2024 NOW" R/ [A-Z]+-\d+/ matches? .   ! => f   (extra text after)
"sale-2024"     R/ [A-Z]+-\d+/ matches? .   ! => f   (lowercase letters)
```

Even though `SALE-2024` sits inside `"GET SALE-2024"`, `matches?` still
says `f`: the extra characters are part of the string and they don't
fit the pattern. When you only care whether the pattern appears
*somewhere*, reach for `re-contains?` — it returns `t` exactly where
`matches?` returned `f`:

```
re-contains? ( string regexp -- ? )
```

```factor
USING: regexp ;

"GET SALE-2024" R/ [A-Z]+-\d+/ matches? .      ! => f
"GET SALE-2024" R/ [A-Z]+-\d+/ re-contains? .  ! => t
```

## Finding matches inside longer text

`re-contains?` tells you only *whether* the pattern is in there. These
next words look inside and report *what* matched: `all-matching-subseqs`
returns every place the pattern matches, as a sequence of strings, and
`count-matches` just counts them:

```
all-matching-subseqs ( string regexp -- seq )
count-matches        ( string regexp -- n )
```

```factor
USING: regexp ;

"3 cats, 12 dogs, 1 fish" R/ \d+/ all-matching-subseqs .
! => { "3" "12" "1" }            (every run of digits)

"the quick fox" R/ \S+/ all-matching-subseqs .
! => { "the" "quick" "fox" }     (every run of non-space characters)

"id_7!" R/ \w/ count-matches .   ! => 4   (i, d, _ and 7 count; ! does not)
```

## Replacing matches

`re-replace` swaps every match for a piece of replacement text and
returns the new string:

```
re-replace ( string regexp replacement -- result )
```

```factor
USING: regexp ;

"page 7 of 12" R/ \d+/ "N" re-replace .
! => "page N of N"
```

The `regexp` vocabulary has more words worth knowing — follow the
links for details: [`first-match`][first-match] (the first match only)
and [`re-split`][re-split] (split a string wherever the pattern
matches).

[regexp]: https://docs.factorcode.org/content/vocab-regexp.html
[first-match]: https://docs.factorcode.org/content/word-first-match%2Cregexp.html
[re-split]: https://docs.factorcode.org/content/word-re-split%2Cregexp.html

## Instructions

You run the security desk at a research station. Staff carry *badges*
whose codes follow a strict format, the access log is full of those
codes mixed into ordinary text, and the log has to be cleaned up
before it can be shared. Regular expressions are the right tool for
each of these jobs.

A valid badge code is **two capital letters, a dash, then four
digits** — for example `NS-1024`.

## 1. Check a badge code

Define `valid-badge?`, taking a badge string and returning `t` when
the *whole* string is a valid badge code and `f` otherwise.

```factor
"NS-1024" valid-badge? .   ! => t
"NS-10"   valid-badge? .   ! => f
```

## 2. Pull every code out of a log line

Define `badge-codes`, taking a line of the access log and returning a
sequence of all the badge codes that appear in it, in order.

```factor
"seen NS-1024 then AB-0007 today" badge-codes .
! => { "NS-1024" "AB-0007" }
```

## 3. Count the digits in a code

Define `digit-count`, taking a string and returning how many digits it
contains.

```factor
"NS-1024" digit-count .   ! => 4
```

## 4. Redact passwords

Log lines sometimes record a password as `pass=` followed by the
secret (any run of non-space characters). Define `redact`, taking a
line and returning it with every such password replaced by
`pass=****`.

```factor
"user=alice pass=hunter2 ok" redact .
! => "user=alice pass=**** ok"
```

## Source

### Created by

- @keiravillekode