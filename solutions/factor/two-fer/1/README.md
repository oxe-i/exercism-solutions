# Two Fer

Welcome to Two Fer on Exercism's Factor Track.
If you need help running the tests or submitting your code, check out `HELP.md`.

## Introduction

In some English accents, when you say "two for" quickly, it sounds like "two fer".
Two-for-one is a way of saying that if you buy one, you also get one for free.
So the phrase "two-fer" often implies a two-for-one offer.

Imagine a bakery that has a holiday offer where you can buy two cookies for the price of one ("two-fer one!").
You take the offer and (very generously) decide to give the extra cookie to someone else in the queue.

## Instructions

Your task is to determine what you will say as you give away the extra cookie.

If you know the person's name (e.g. if they're named Do-yun), then you will say:

```text
One for Do-yun, one for me.
```

If you don't know the person's name, you will say _you_ instead.

```text
One for you, one for me.
```

Here are some examples:

| Name   | Dialogue                    |
| :----- | :-------------------------- |
| Alice  | One for Alice, one for me.  |
| Bohdan | One for Bohdan, one for me. |
|        | One for you, one for me.    |
| Zaphod | One for Zaphod, one for me. |

## Words

`2-for-1 ( name -- str )` takes either a string name or `f` for
the no-name case.

```factor
"Alice" 2-for-1   ! "One for Alice, one for me."
f 2-for-1         ! "One for you, one for me."
```

## Source

### Created by

- @catb0t

### Contributed to by

- @sjwarner-bp

### Based on

https://github.com/exercism/problem-specifications/issues/757