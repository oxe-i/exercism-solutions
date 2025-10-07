# inventory-management

Welcome to inventory-management on Exercism's x86-64 Assembly Track.
If you need help running the tests or submitting your code, check out `HELP.md`.
If you get stuck on the exercise, check out `HINTS.md`, but try and solve it without using those first :)

## Introduction

## Integers

### Binary Notation

An `integer` is an abstraction that represents whole numbers, such as `4`, `-2`, `0` or `64532`.

In order to represent an `integer` as a sequence of bytes, the `binary notation` is used.

This means each bit in the sequence represents a distinct power of two.

In x86-64, those bits are counted in ascending order from the smallest index.
This means x86-64 is `little endian`.

### Unsigned and Signed Integers

#### Unsigned numbers

If the number can only be non-negative, it's called an `unsigned` number.

Unsigned numbers are represented directly as the sum of all set bits in its sequence.

The range of representable non-negative integers in a register goes from `0` (no bit set) to `2⁶⁴ - 1` (sum of all 64 bits set).

#### Signed numbers

If an integer can assume positive or negative values, it's called a `signed` number.

In order to represent negative numbers, x86-64 uses the `two's complement` representation.

The `neg` instruction can be used to change the sign of a number.

~~~~exercism/caution

In assembly, there's no way to tell if a sequence of bytes represents a signed or an unsigned number.
It's the programmer's responsibility to give meaning to those bytes.

The use of comments can be a great aid in this task.

~~~~

### Arithmetic

#### Sum

The addition of two numbers can be calculated using the `add` instruction.

Sometimes, the sum of two numbers leaves an excessive bit that does not fit into the destination operand.
This bit is stored in a special flag called the `carry flag (CF)`.
The `CF` can also be set by other instructions, performing other operations.

The instruction `adc` can be used to sum two numbers and also the value in the `carry flag`.
It is a two-operand instruction, with the same syntax as `add`.

There's also a `inc` one-operand instruction, that sums 1 to the value in its operand.

The sum of two integers operates in the same way for both unsigned and signed numbers.

### Subtraction

The subtraction of two integers is performed using the `sub` instruction.

There's also a `dec` one-operand instruction, that subtracts 1 from the value in its operand:

The subtraction of two integers also operates in the same way for both unsigned and signed numbers.

### Multiplication

There are two different instructions to perform multiplication between two numbers in x86-64.
As a rule, unsigned multiplication uses the instruction `mul`, while signed multiplication uses `imul`.

The `mul` instruction takes the following one-operand form, where src is the source operand:

```nasm
mul src
```

The `imul` instruction can take a one-operand, two-operand or three-operand form:

```nasm
imul src
imul dest, src
imul dest, src1, src2
```

#### One-operand form

Two registers are implicitly used to perform a multiplication in one-operand form: `rax` and `rdx`.
If the multiplication involves two 64-bit numbers, then the lower 64-bits of the result will be in `rax` and the upper 64-bits will be in `rdx`.

This is usually called `rdx:rax`, to indicate that both registers are used in tandem.

The same happens if the multiplication involves different register sizes.
So, for instance, if two 32-bit numbers are being multiplied, `eax` and `edx` will be used.

The exception is the multiplication between two bytes.

In this case, instead of `dl:al`, `ax` will be used.
The lower portion of `ax` (`al`) will get the lower 8-bits of the product, while the upper portion (`ah`) will get the upper 8-bits.

~~~~exercism/caution
The `rdx` register is implicitly used in an one-operand multiplication.
This means any necessary value in `rdx` must be saved before that operation.
~~~~

#### Two-operand form

The two-operand form of `imul` allows for explicitly declaring a different destination operand.

In that case, the product between source and destination operands is placed in the destination operand.
This product is truncated to fit into the destination operand.

#### Three-operand form

The three-operand form of `imul` multiplies the two source operands and places the result in the destination operand.

This means that the destination operand is not multiplied with any of the source operands, it just receives the result.
This product is also truncated to fit into the destination operand.

#### Handling overflow

In case of a possible overflow, it is sometimes useful to move operands to a larger register size.

A `movzx` instruction can be used to convert a value in a 8-bits or 16-bits source operand to a larger destination operand, clearing all remaining bits (this is called `zero extension`):

```nasm
mov ax, 1000 ; lower 16-bits of eax are 1000, upper bits are undefined
mov cx, 200 ; lower 16-bits of ecx are 200, upper bits are undefined

; 200 * 1000 does not fit in 16-bits, so a 32-bits multiplication is necessary
; however, multiplying eax by ecx may produce an incorrect result due to undefined bits

movzx eax, ax ; lower 16-bits of eax remain 1000, upper bits are cleared
movzx ecx, cx ; lower 16-bits of ecx remain 200, upper bits are cleared
mul ecx ; now eax correctly holds 200 * 100
```

A 32-bits source operand is always zero-extended to all 64-bits of the destination operand with a simple `mov`.

#### Using imul with unsigned numbers

It is possible to use `imul` to multiply unsigned numbers.
However, this may give an incorrect result if one of the numbers may be interpreted as negative.

Since the `sign bit` corresponds to the most significant bit in an unsigned integer, in practice, this difference becomes relevant when more than the truncated result is needed, ie, when the full range of `rdx:rax` is used.

### Division

As is the case with multiplication, there are also two instructions to perform division between two numbers.
Unsigned division uses the instruction `div`, while signed division uses `idiv`.

Both instructions work with only one operand:

```nasm
div src
idiv src
```

In both cases, the value in `rdx:rax` is divided by the value in the source operand.
The quotient is written to the `rax` register and the remainder is written to the `rdx` register.

Notice that as `rdx:rax` is the dividend, both registers must have the appropriate bits set.

So, whenever working with 64-bits integers, all bits in the `rdx` register must be cleared for a non-negative number in `rax`, and set for a negative number.
This is called `sign extension`.

Failing to perform sign extension can cause a wrong result for the division or, if the quotient is too large to fit in `rax`, an error.

There are three instructions that automate this process: `cwd`, `cdq` and `cqo`.
They perform sign extension from `ax` to `dx`, from `eax` to `edx` and from `rax` to `rdx`, respectively.

There's no equivalent instruction for sign extending `al` to `dl` because division between two bytes operate differently.
Instead of using `dl:al`, `ax` is used.

So, the lower 8-bits of `ax` (`al`) will get the quotient of the operation and the higher 8-bits (`ah`) will get the remainder.

There is also the instruction `movsx` that works similarly to `movzx`, extending from any 8-bits or 16-bits source operand to a larger destination operand.
While `movzx` performs zero-extension, however, `movsx` performs sign-extension.

A variant of `movsx` called `movsxd` can sign-extend from a 32-bits source operand to a 64-bits destination operand, as well as between two 16-bits or two 32-bits operands.

~~~~exercism/caution
The `rdx` register is implicitly used in an integer division.
This means any necessary value in `rdx` must be saved before that operation.
~~~~

## Instructions

A local store is moving its inventory to a larger warehouse.
You were hired to pack and move everything.

You have four tasks, all related to managing the transport.

## 1. Get weight of each box

Items are being packed in boxes that must be labeled with their weight.
There is no scale around, but luckily you know how much each item weighs on average.

In order to better organize things, a box holds only items of two different products.

Define a function `get_box_weight` that returns the total weight of a box, in `g`.
This function takes as parameters, in this order:

- The number of items for the first product in the box
- The weight of each item of the first product, in `g`
- The number of items for the second product in the box
- The weight of each item of the second product, in `g`

Consider that an empty box weighs **500 g**.

Example:

```c
get_box_weight(30, 40, 50, 20);
// => 2700
```

All arguments are 16-bit non-negative integers, and the return value is a 32-bit non-negative integer.

## 2. Calculate how many boxes fit into the truck

Boxes are being stacked and moved to the new warehouse in a truck.
However, there is only so much vertical space in the truck.

Define a function `max_number_of_boxes` that returns how many boxes of a certain height can be stacked vertically (one on top of another) within the truck.

This function takes as parameter the height of the box, in `cm`.
Consider that the truck interior height is **300 cm**.

Example:

```c
max_number_of_boxes(30);
// => 10
```

The argument and the return value are 8-bit non-negative integers.

## 3. Check if all products are accounted for

There is a checklist in the new warehouse with the number of items still unaccounted for each product.
For each new box moved there, you need to calculate the new value in the checklist for each product in the box.

Define a function `items_to_be_moved` that returns how many items remain to be moved to the new warehouse for a given product.
This function takes as parameters, in this order:

- The number of items still unaccounted for a product
- The number of items for the product in a box

Example:

```c
items_to_be_moved(76532, 120);
// => 76412
```

The arguments are 32-bit non-negative integers.
The return value is a 32-bit integer.
In case of an error in the process, it is possible that the result is a negative number.

## 4. Get payment

Your payment is based on how many boxes were moved and how many truck trips were necessary.
For each box, you will be paid **5 dollars** and for each trip, you will be paid **220 dollars**.
You may have received part of this payment up front to cover initial costs.

However, some products are not covered by insurance and your payment will be reduced by the value of any of those items broken or missing.
It is possible that you end up owing money if you are not careful!

This payment, or debt, will be divided equally between you and a number of workers you hired.
Any remaining money, or debt, is yours.

Define a function `calculate_payment` that returns how much you should be paid, or pay, at the end.
This function takes as parameters, in this order:

- How much you have received up front, as a 64-bit non-negative integer
- The total number of boxes moved, as a 32-bit non-negative integer
- The number of truck trips made, as a 32-bit non-negative integer
- The number of broken or missing items, as a 32-bit non-negative integer
- The value of each lost item, as a 64-bit non-negative integer
- The number of workers to split the payment or debt with you, as a 8-bit positive integer

Example:

```c
calculate_payment(2000, 1000, 5, 21, 2, 1);
// => 2029
```

The return value is a 64-bit integer.

## Source

### Created by

- @oxe-i