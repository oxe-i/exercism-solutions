# Pythagorean Triplet

Welcome to Pythagorean Triplet on Exercism's JavaScript Track.
If you need help running the tests or submitting your code, check out `HELP.md`.

## Introduction

You are an accomplished problem-solver, known for your ability to tackle the most challenging mathematical puzzles.
One evening, you receive an urgent letter from an inventor called the Triangle Tinkerer, who is working on a groundbreaking new project.
The letter reads:

> Dear Mathematician,
>
> I need your help.
> I am designing a device that relies on the unique properties of Pythagorean triplets — sets of three integers that satisfy the equation a² + b² = c².
> This device will revolutionize navigation, but for it to work, I must program it with every possible triplet where the sum of a, b, and c equals a specific number, N.
> Calculating these triplets by hand would take me years, but I hear you are more than up to the task.
>
> Time is of the essence.
> The future of my invention — and perhaps even the future of mathematical innovation — rests on your ability to solve this problem.

Motivated by the importance of the task, you set out to find all Pythagorean triplets that satisfy the condition.
Your work could have far-reaching implications, unlocking new possibilities in science and engineering.
Can you rise to the challenge and make history?

## Instructions

A Pythagorean triplet is a set of three natural numbers, {a, b, c}, for which,

```text
a² + b² = c²
```

and such that,

```text
a < b < c
```

For example,

```text
3² + 4² = 5².
```

Given an input integer N, find all Pythagorean triplets for which `a + b + c = N`.

For example, with N = 1000, there is exactly one Pythagorean triplet for which `a + b + c = 1000`: `{200, 375, 425}`.

By default, only `sum` is given to the `triplets` function, but it may optionally also receive `minFactor` and/or `maxFactor`. When these are given, make sure _each_ factor of the triplet is at least `minFactor` and at most `maxFactor`.

<!-- prettier-ignore-start -->
~~~exercism/advanced
If you're solving this using the CLI, there's a test case involving large numbers that's currently skipped to avoid timeouts in our test runner.
You can enable it if you want by removing the `.skip`, just be aware that it may take a while to run.
~~~
<!-- prettier-ignore-end -->

## Source

### Created by

- @matthewmorgan

### Contributed to by

- @ankorGH
- @rchavarria
- @ryanplusplus
- @SleeplessByte
- @tejasbubane
- @xarxziux

### Based on

A variation of Problem 9 from Project Euler - https://projecteuler.net/problem=9