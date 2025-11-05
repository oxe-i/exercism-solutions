# Currency Exchange

Welcome to Currency Exchange on Exercism's x86-64 Assembly Track.
If you need help running the tests or submitting your code, check out `HELP.md`.
If you get stuck on the exercise, check out `HINTS.md`, but try and solve it without using those first :)

## Introduction

In previous concepts, it was mentioned that the `global` directive makes a function or variable defined in one source file visible to other files.
Similarly, the `extern` directive informs the assembler that a function or variable used in the current source file is defined in another one.

Those two directives are the main way assembly code interacts with other source files to achieve modularization.

For the purposes of these directives, it is indifferent if the external code is defined or used in assembly or in a high-level language.
So, for example, even a function defined in a high-level language may be used in x86-64 code if declared `extern`.

In the same way, the calling convention is shared across all of those functions, defined in assembly or in high-level languages, and even with the Operating System (OS).

However, since in assembly data is just a sequence of bytes, it is important to be aware of how the interfacing high-level language manages memory.

## C Types

The C language is a common choice for a high-level language to interface with assembly code.
It makes the task of interacting with the OS easier, offering high-level wrappers for many important tasks, such as printing to the screen, reading from a keyboard or allocating dynamic memory.

In this track, the tests are written in C and so it is important to offer a general overview of the language.

~~~~exercism/note
Any of the types indicated below may be qualified with `const`.
This makes them read-only.
~~~~

### Primitive Types

There are many primitive types in C and their size, in bytes, may vary.
Some of them are summarized in the following table, with their typical size in a x86-64 system:

| type      | number of bytes | integer/floating-point |
|-----------|-----------------|------------------------|
| _Bool     | 1               | integer                |
| char      | 1               | integer                |
| short     | 2               | integer                |
| int       | 4               | integer                |
| long      | 4 or 8          | integer                |
| long long | 8               | integer                |
| float     | 4               | floating-point         |
| double    | 8               | floating-point         |

Each one of those integral types can be signed (the default) or unsigned.
In case they are unsigned, this must be specified, for example: `unsigned int`.

There are aliases for the integral types that are defined to provide precise control over their size:

| alias   | number of bytes |
|---------|-----------------|
| int8_t  | 1               |
| int16_t | 2               |
| int32_t | 4               |
| int64_t | 8               |

Those aliases may be prefixed by `u` to indicate an unsigned type, for example: `uint64_t`.

Other aliases of note are:

| alias  | type                                          |
|--------|-----------------------------------------------|
| bool   | _Bool                                         |
| size_t | usually an unsigned 8-byte integer            |

A `_Bool`, or its alias `bool`, is unique in that, although it occupies 1 entire byte, it can only assume one of two values: `true` (`1`) and `false` (`0`).

Values of those primitive types are passed to, and returned from, functions according to the usual rules for integers and floating-point values.

### Enums

An **enum** is a type that can assume one of a number of explicitly indicated elements:

```c
enum example {
    example_1,
    example_2,
    example_3,
    example_4
};
```

In C, enums are implicitly converted to an integer type, which is typically an `int`, i.e., a 4-byte integer.

By default the first possible element in an enum is converted to `0` and all subsequent elements are converted to the next integer.
So, in the `enum example` defined above, `example_1` would have value `0`, `example_2` would have value `1` and so on.

It is possible to indicate the value for any element of an enum and then, by default, the next element would have the next integer as value:

```c
enum example_2 {
    example_1 = 4,
    example_2 = 8,
    example_3
}; // example_3 is equal to 9
```

### Memory addresses

In C, a memory address is referenced by a **pointer** to a type and denoted with the `*` operator.
So, for example, `int64_t *` refers to a memory location for one or more `int64_t`.

Addresses are treated as 8-byte integers, as usual.

### Arrays

Arrays are passed to, and returned from, functions as pointers to their first element.

```c
int64_t example_arr[] = {1, 2, 3}; // this is an array of 3 signed 8-byte integers
fn(example_arr); // this is a function that passes a pointer (int64_t *) to the beginning of the array as an argument
```

Each element in an array has the size of the array's element type.
The `example_arr` defined above, for example, has 3 elements of 8 bytes each, which is 24 bytes in total.

Because arrays do not store their length, a separate value is usually necessary to indicate the number of elements unless a sentinel value marks the end.

### Strings

Strings in C are an array of `char`, which is a 1-byte type.
Most strings are of ASCII characters and NUL-terminated, so they end when a byte with the value `0` is found.
This means the length of a string does not usually need to be passed as a separate argument.

## Instructions

Your friend Chandler plans to visit exotic countries all around the world.
Sadly, Chandler's math skills aren't good.
He's pretty worried about being scammed by currency exchanges during his trip - and he wants you to make a currency calculator for him.

Here are his specifications for the app.

~~~~exercism/note
The functions in this exercise are declared in a C source file with the provided signatures.
Your x86-64-assembly code must follow those specifications.
~~~~

## 1. Keep track of different currencies

You have created a `enum currency_t` to keep track of different currencies Chandler uses in his travels:

```c
enum currency_t {
    GBP,
    EUR,
    JPY,
    AUD,
    BRL,
    CNY,
    CAD,
    INR
};
```

You sometimes need to print those currencies on the screen so you can check if they are right.

Create the `stringify_currency` function:

```c
void stringify_currency(char *buffer, enum currency_t currency);
```

This function has no return value and should store a C-style string in the location indicated by `buffer`.
The string should visually represent which kind of currency was passed to the function:

```c
char buffer[4];
stringify_currency(buffer, CAD);
// => "CAD"
```

## 2. Check the exchange rate

Create the `exchange_rate` function:

```c
double exchange_rate(enum currency_t domestic_currency, enum currency_t foreign_currency, const double *value_in_US_dollars);
```

The `domestic_currency` argument represents Chandler's local currency to be exchanged for a `foreign_currency`.

`value_in_US_dollars` is a pointer to an array of `double` that contains the value of one unit of each currency in US dollars.
Currencies are indexes in this array.
So, if `EUR` is a valid element for `enum currency_t`, then `value_in_US_dollars[EUR]` yields the value of `1 EUR` in US dollars.

This function should return the value of one unit of foreign currency in the domestic currency.

```c
const double value_in_US_dollars[8] = {
    1.33329, 1.16443, 0.00654374, 0.650888,
    0.185577, 0.140420, 0.714142, 0.0113863
};

exchange_rate(JPY, GBP, value_in_US_dollars);
// => 203.750454633
```

## 3. Calculate value of bills

Create the `get_value_of_bills` function:

```c
uint64_t get_value_of_bills(unsigned long long denomination, unsigned short number_of_bills);
```

The argument `denomination` is the value of a single bill, whereas `number_of_bills` is the total number of bills.

This exchanging booth only deals in cash of certain increments.
The total you receive must be divisible by the value of one "bill" or unit, which can leave behind a fraction or remainder.
Your function should return only the total value of the bills (_excluding fractional amounts_) the booth would give back.
Unfortunately, the booth gets to keep the remainder/change as an added bonus.

```c
get_value_of_bills(5, 128);
// => 640
```

## 4. Calculate number of bills

Create the `get_number_of_bills` function:

```c
unsigned int get_number_of_bills(float amount, unsigned long long denomination);
```

This function should return the _number of currency bills_ that you can receive within the given _amount_.
In other words:  How many _whole bills_ of currency fit into the starting amount?
Remember -- you can only receive _whole bills_, not fractions of bills, so remember to divide accordingly.
Effectively, you are rounding _down_ to the nearest whole bill/denomination.

```c
get_number_of_bills(127.5, 5);
// => 25
```

## 5. Calculate value after exchange

Create the `exchangeable_value` function:

```c
uint32_t exchangeable_value(float budget, double exchange_rate, uint8_t spread, unsigned long long denomination);
```

Parameter `spread` is the _percentage taken_ as an exchange fee, written as an integer.
It needs to be converted to decimal by dividing it by 100.
Note that the spread is added to the exchange rate, so that a spread of `10` results in a exchange rate 10% higher.

This function should return the maximum value of the new currency after calculating the *exchange rate* adjusted by the *spread*.
Remember that the currency *denomination* is a whole number, and cannot be sub-divided.

```c
exchangeable_value(127.25, 0,873350884, 10, 20);
// => 120
exchangeable_value(127.25, 0,873350884, 10, 5);
// => 130
```

## Source

### Created by

- @oxe-i