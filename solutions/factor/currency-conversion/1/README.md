# Currency Conversion

Welcome to Currency Conversion on Exercism's Factor Track.
If you need help running the tests or submitting your code, check out `HELP.md`.
If you get stuck on the exercise, check out `HINTS.md`, but try and solve it without using those first :)

## Introduction

This exercise builds on the integer arithmetic from
[Leah's Luscious Lasagna][lasagna]. Here you will work with floating-
point numbers and pick the right division word for the job.

## Integers and floats

Factor distinguishes integers (`1`, `42`, `1_000_000`) from floating-
point numbers (`1.0`, `3.14`, `6.02e23`). If you mix an integer and a
float in one calculation, the result comes out as a float:

```factor
2 3 + .      ! => 5
2 3.0 + .    ! => 5.0
```

Underscores are allowed inside number literals as digit separators
and are ignored by the parser.

## Division words

Factor has separate division words. They all live in the [`math`][math]
vocabulary.

```
/    ( x y -- x/y )    ! exact: ratio for two integers, float if either is a float
/f   ( x y -- f   )    ! always a float
/i   ( x y -- q   )    ! integer division (truncates toward zero)
mod  ( x y -- r   )    ! remainder
/mod ( x y -- q r )    ! quotient and remainder together
```

```factor
1 2 / .        ! => 1/2     (a proper ratio)
16 3 / .       ! => 5+1/3   (an improper ratio, printed as a mixed numeral)
16 3 /f .      ! => 5.333333333333333
16 3 /i .      ! => 5      (truncated)
16 3 mod .     ! => 1
16 3 /mod .s   ! quotient and remainder in one pass
! => 5
! => 1
16.0 3 / .     ! => 5.333333333333333
```

`/` produces a `ratio` (Factor's exact rational type) for two integers,
or a `float` if either input is a float. `/f` forces a float result
even for two integers. `/i` always truncates toward zero.

## Checking

Number predicates from [`math`][math], [`math.functions`][math.functions],
and [`math.primes`][math.primes]:

```
zero?    ( x       -- ? )
even?    ( x       -- ? )
odd?     ( x       -- ? )
prime?   ( x       -- ? )
divisor? ( m n     -- ? )    ! true when n divides m
integer? ( x       -- ? )    ! true for ints (fixnum or bignum)
float?   ( x       -- ? )    ! true for floats
number?  ( x       -- ? )    ! true for any numeric kind
```

```factor
0 zero? .            ! => t
0.0 zero? .          ! => t
3 zero? .            ! => f

4 even? .            ! => t
7 even? .            ! => f
7 odd? .             ! => t

7 prime? .           ! => t
9 prime? .           ! => f

15 5 divisor? .      ! => t   (5 divides 15)
15 4 divisor? .      ! => f
```

## Float to integer

`floor`, `ceiling`, and `round` from the
[`math.functions`][math.functions] vocabulary all return a float
(`3.0`, not `3`). To get a true integer, chain `>integer`:

```factor
3.7 floor >integer .       ! => 3
3.2 ceiling >integer .     ! => 4
```

## Powers and absolute value

`sq`, `^`, and `abs` (in [`math.functions`][math.functions])
compute squares, arbitrary powers, and absolute values:

```
sq  ( x   -- x*x )
^   ( x y -- x^y )
abs ( x   -- |x| )
```

```factor
5 sq .          ! => 25
2 10 ^ .        ! => 1024
2 0.5 ^ .       ! => 1.4142135623730951
-7 abs .        ! => 7
3 abs .         ! => 3
```

## Min and max

`min ( x y -- z )` and `max ( x y -- z )` (in
[`math.order`][math.order]) return the lesser or greater of two
numbers:

```factor
3 7 min .       ! => 3
3 7 max .       ! => 7
```

The most common use is *clamping* — pinning a value to a floor
with `max` (e.g., `0 max` keeps a value non-negative) or to a
ceiling with `min`.

## Ordering predicates

`math.order` also provides `before?`, `after?`, `before=?`,
`after=?` for comparison predicates that work on any orderable
type — numbers, strings, characters:

```
before?  ( obj1 obj2 -- ? )   ! obj1 <  obj2
before=? ( obj1 obj2 -- ? )   ! obj1 <= obj2
after?   ( obj1 obj2 -- ? )   ! obj1 >  obj2
after=?  ( obj1 obj2 -- ? )   ! obj1 >= obj2
```

Use these instead of `<`/`<=` when the values might be strings —
the arithmetic operators don't dispatch on strings.

[lasagna]: https://exercism.org/tracks/factor/exercises/lasagna
[math]: https://docs.factorcode.org/content/vocab-math.html
[math.functions]: https://docs.factorcode.org/content/vocab-math.functions.html
[math.order]: https://docs.factorcode.org/content/vocab-math.order.html
[math.primes]: https://docs.factorcode.org/content/vocab-math.primes.html

## Instructions

Your friend Chandler plans to visit exotic countries all around the
world. Sadly, Chandler's math skills aren't good. He's pretty worried
about being scammed by currency exchanges during his trip — and he
wants you to make a currency calculator for him.

## 1. Estimate value after exchange

Define `exchange-money` taking a `budget` and an `exchange-rate` and
returning the value of the exchanged currency.

**Note:** if your currency is USD and you want to exchange USD for EUR
with an exchange rate of `1.20`, then `1.20 USD == 1 EUR`.

```factor
127.5 1.2 exchange-money .
! => 106.25
```

## 2. Calculate currency left after an exchange

Define `get-change` taking a `budget` (before the exchange) and the
`exchanging-value` (the amount taken from the budget to be exchanged).
Return the amount of money that is left.

```factor
127.5 120 get-change .
! => 7.5
```

## 3. Calculate value of bills

Define `value-of-bills` taking a `denomination` (the value of a single
bill) and a `number-of-bills`. Return the total value of the bills.

```factor
5 128 value-of-bills .
! => 640
```

## 4. Calculate number of bills

Define `number-of-bills` taking an `amount` and a `denomination`.
Return the number of *whole bills* of the given denomination that fit
into the amount. Round down — fractional bills don't exist.

```factor
127.5 5 number-of-bills .
! => 25
```

## 5. Calculate leftover after exchanging into bills

Define `leftover-of-bills` taking an `amount` and a `denomination`.
Return the leftover amount that cannot be returned as whole bills.

```factor
127.5 20 leftover-of-bills .
! => 7.5
```

## 6. Calculate value after exchange

Define `exchangeable-value` taking a `denomination`, `budget`,
`spread`, and `exchange-rate`.

`spread` is the *percentage* taken as an exchange fee, written as an
integer. It needs to be added to the exchange rate as a fraction. If
`1.00 EUR == 1.20 USD` and the spread is `10`, the total exchange rate
is `1.00 EUR == 1.32 USD` (10% of 1.20 is 0.12, added to 1.20).

Return the maximum value of the new currency after applying the rate
plus spread, rounded down to whole bills of the given `denomination`.
The returned value is an integer.

```factor
20 127.25 10 1.20 exchangeable-value .
! => 80

5 127.25 10 1.20 exchangeable-value .
! => 95
```

## 7. Safe change

Like `get-change`, but if Chandler accidentally typed an
exchanging value larger than his budget, return `0` instead of
a negative number. Define `safe-change` taking a `budget` and an
`exchanging-value`.

```factor
127.5 120 safe-change .
! => 7.5

50 100 safe-change .
! => 0
```

## 8. Cap by budget

Chandler is haggling for a souvenir. Define `cap-spend` taking a
`budget` and a `price`, and returning whichever is smaller — the
most he can actually pay.

```factor
100 30 cap-spend .
! => 30

20 30 cap-spend .
! => 20
```

## Source

### Created by

- @keiravillekode