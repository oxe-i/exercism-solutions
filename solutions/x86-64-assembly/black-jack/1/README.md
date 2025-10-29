# Black Jack

Welcome to Black Jack on Exercism's x86-64 Assembly Track.
If you need help running the tests or submitting your code, check out `HELP.md`.
If you get stuck on the exercise, check out `HINTS.md`, but try and solve it without using those first :)

## Introduction

## Conditionals

### RFLAGs

There's a special register called `rflags`.
Its bits act like flags for various conditions.

Some of those are listed below:

| name     | symbol | bit |
|:---------|:------:|:---:|
| carry    | CF     | 0   |
| zero     | ZF     | 6   |
| sign     | SF     | 7   |
| overflow | OF     | 11  |

### Comparison Instructions

The flags in `rflags` are set by many different instructions.

Two of the most common instructions used to test conditions are `cmp` and `test`.
They both take two operands and update the flags, but **do not modify their operands**.

#### CMP Instruction

The `cmp` instruction subtracts the second operand from the first and sets flags according to the result.

If A is the first operand and B, the second:

| flag | set when                       |
|:----:|:-------------------------------|
| CF   | A < B (unsigned)               |
| ZF   | A == B                         |
| SF   | A < B (signed)                 |
| OF   | overflow in signed subtraction |

#### TEST Instruction

The `test` instruction makes a bitwise AND between both operands and sets flags according to the result.

If A is the first operand and B, the second:

| flag | set when             |
|:----:|:---------------------|
| CF   | always cleared       |
| ZF   | A AND B == 0         |
| SF   | A AND B < 0 (signed) |
| OF   | always cleared       |

### Branching

As a default, code in x86-64 executes sequentially from top to bottom.

But there are many situations where it's necessary to modify this behavior.
For instance, to execute a different set of instructions in response to a condition.

In higher-level languages, this is usually done with abstractions such as `if...else` conditionals.
However, those do not exist in x86-64.

Instead, x86-64 provides instructions that effectively transfer execution to another location of the code.
This is called `branching`.

#### Unconditional Jump

The instruction `jmp` unconditionally transfers execution of the program to another point of the code.
Its single operand is a label which has the address to the point where execution will continue.

Consider, for instance, the following function:

```nasm
fn:
    mov rax, 5
    jmp end

    add rax, 10
end:
    ret
```

When `fn` is called, execution starts at `mov rax, 5`.
This sets the value in `rax` to be 5 at that point.

The next instruction is `jmp end`, which transfers execution to the label `end`.

After `end`, the next instruction is `ret`, which transfers execution back to the caller function.

Notice that, since `add rax, 10` is located after `jmp end` and before `end`, it is never executed.
The value of `rax` when `fn` returns is 5.

#### Conditional Jump

The family of instructions `jcc` transfers execution of the program to another point only if a specific condition is met.
Otherwise, execution continues sequentially.

Each condition maps to one or more flags in `rflags`.
Some `jcc` variants test that a flag is set, others test that it is cleared.

The `cc` in `jcc` is not literal, but refers to the specific suffix associated with the flag tested.

There are many suffixes and many of them test the same condition as another.
This is because many of them are chosen in order to refer to their meaning in a `cmp` instruction.

For example, `jz` (suffix `z`, for `ZF`) and `je` (suffix `e`, for equal) both jump when `ZF` is set.
This is because, with `cmp`, `ZF` is set when the subtraction yields zero, which corresponds to the two operands being equal.

The following table shows some of the possible suffixes and their meaning.
Consider that A is the first operand, and B the second, in a `cmp` instruction.

| suffix | meaning          |
|:------:|:-----------------|
| e      | A == B           |
| l      | A < B (signed)   |
| b      | A < B (unsigned) |
| g      | A > B (signed)   |
| a      | A > B (unsigned) |

It's possible to add `e` after `l`, `b`, `g` or `a` to include the equality in the condition.

For instance, `jge` jumps when A >= B (A and B interpreted as signed integers).

There are also suffixes which refer directly to the flag being tested:

| suffix | flag |
|:------:|:----:|
| z      | ZF   |
| c      | CF   |
| s      | SF   |
| o      | OF   |

For all suffixes, there are variants which check the opposite behavior.
They have the same syntax, but with a `n` before the suffix.

For instance, `jnz` jumps when `ZF` is **not** set.
Similarly, `jnae` jumps when A is **not** >= B (A and B interpreted as unsigned integers).

### Local Labels

Labels are visible in the entire source file, they are not local to a function.
So it is impossible to reuse a label name.

In order to mimic the behavior of a local label, NASM has a special notation for a label declared with a period (`.`) before it.
This notation defines a label which implicitly includes the name of the previous non-dotted label:

```nasm
section .text
fn1:
    ...
.example: ; this is fn1.example
    ...
    ret

fn2:
    ...
.example: ; this is fn2.example
    ...
    ret
```

It is still possible to jump to this label from anywhere in the code by using the full label name, for instance, `jmp fn1.example`.

However, a jump that uses the part of the label starting at the dot will be made to the label _inside_ the upper function.
So, `.example` behaves as if it was local to the function, either `fn1` or `fn2`.

Notice that a non-dotted label inside a function in practice defines another function:

```nasm
section .text
fn1:
    ...
.example: ; this is 'fn1.example'
    ...
non_dotted:
    ...
.example: ; this is 'non_dotted.example'
    ...
    ret
```

## Instructions

In this exercise you are going to implement some rules of [Blackjack][blackjack],
such as the way the game is played and scored.

~~~~exercism/note
In this exercise, the cards are represented as numbers, such that each number card is represented as its numerical value, jack is 11, queen is 12, king is 13 and ace is 14.
Jokers are discarded.

In order to make it easier to work with this representation, constants are defined at the top of the file, such that C2 to C10 is a number card, CJ is jack, CQ is queen, CK is king and CA is ace.

A [standard French-suited 52-card deck][standard_deck] is assumed, but in most versions, several decks are shuffled together for play.
~~~~

## 1. Calculate the value of a card

In Blackjack, it is up to each individual player if an ace is worth 1 or 11 points (_more on that later_).
Face cards (joker, queen and king) are scored at 10 points and any other card is worth its "pip" (_numerical_) value.

Define the `value_of_card` function with parameter `card`, a number representing a card.
The function should return the _numerical value_ of the passed-in card.
Since an ace can take on multiple values (1 **or** 11), this function should fix the value of an ace card at 1 for the time being.
Later on, you will implement a function to determine the value of an ace card, given an existing hand.

```c
value_of_card(13)
// => 10

value_of_card(4)
// => 4

value_of_card(14)
// => 1
```

## 2. Determine which card has a higher value

Define the `higher_card` function having parameters `card_one` and `card_two`, two numbers each representing a card.
For scoring purposes, the value of jack, queen and king is 10.
The function should return which card has the higher value for scoring.
If both cards have an equal value, return both.

An ace can take on multiple values, so we will fix its value to 1 for this task.

```c
higher_card(13, 11)
// => {13, 11}

higher_card(4, 6)
// => 6

>>> higher_card(13, 14)
// => 13
```

~~~~exercism/note
In order to return two integers from a function, you should use both `rax` and `rdx` registers:

```nasm
returning_two_values:
    mov rax, rdi
    mov rdx, rsi
    ret
```

If only one card is returned, `rdx` must be set to 0.
~~~~

## 3. Calculate the value of an ace

As mentioned before, an ace can be worth _either_ 1 **or** 11 points.
Players try to get as close as possible to a score of 21, without going _over_ 21 (_going "bust"_).

Define the `value_of_ace` function with parameters `card_one` and `card_two`, which are two numbers representing a pair of cards already in the hand _before_ getting an ace card.
Your function will have to decide if the upcoming ace will get a value of 1 or a value of 11, and return that value.
Remember: the value of the hand with the ace needs to be as high as possible _without_ going over 21.

**Hint**: if we already have an ace in hand, then the value for the upcoming ace would be 1.

```c
value_of_ace(6, 13)
// => 1

value_of_ace(7, 3)
// => 11
```

## 4. Determine a "Natural" or "Blackjack" Hand

If a player is dealt an ace and a ten-card (10, jack, queen or king) as their first two cards, then the player has a score of 21.
This is known as a **blackjack** hand.

Define the `is_blackjack` function with parameters `card_one` and `card_two`, which are two numbers representing a pair of cards.
Determine if the two-card hand is a **blackjack**, and return 1 if it is, 0 otherwise.
In order to make it easier to work with the values, the constants `TRUE` and `FALSE`, equivalent to 1 and 0 respectively, are defined at the top of the file.

**Note** : The score _calculation_ can be done in many ways.
But if possible, we'd like you to check if there is an ace and a ten-card **_in_** the hand, as opposed to _summing_ the hand values.

```c
is_blackjack(14, 13)
// => 1

is_blackjack(10, 9)
// => 0
```

## 5. Splitting pairs

If the players first two cards are of the same value, such as two sixes, or a queen and a king, a player may choose to treat them as two separate hands.
This is known as "splitting pairs".

Define the `can_split_pairs` function with parameters `card_one` and `card_two`, which are two numbers representing a pair of cards.
Determine if this two-card hand can be split into two pairs.
If the hand can be split, return 1, otherwise, return 0.
In order to make it easier to work with the values, the constants `TRUE` and `FALSE`, equivalent to 1 and 0 respectively, are defined at the top of the file.

```c
can_split_pair(12, 13)
// => 1

can_split_pair(10, 14)
// => 0
```

## 6. Doubling down

When the original two cards dealt total 9, 10, or 11 points, a player can place an additional bet equal to their original bet.
This is known as "doubling down".

Define the `can_double_down` function with parameters `card_one` and `card_two`, which are two numbers representing a pair of cards.
Determine if the two-card hand can be "doubled down", and return 1 if it can, 0 otherwise.
In order to make it easier to work with the values, the constants `TRUE` and `FALSE`, equivalent to 1 and 0 respectively, are defined at the top of the file.

```c
can_double_down(14, 9)
// => 1

can_double_down(10, 2)
// => 0
```

[blackjack]: https://bicyclecards.com/how-to-play/blackjack/
[standard_deck]: https://en.wikipedia.org/wiki/Standard_52-card_deck

## Source

### Created by

- @oxe-i