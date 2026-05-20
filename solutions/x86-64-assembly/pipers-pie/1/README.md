# Piper's Pie

Welcome to Piper's Pie on Exercism's x86-64 Assembly Track.
If you need help running the tests or submitting your code, check out `HELP.md`.
If you get stuck on the exercise, check out `HINTS.md`, but try and solve it without using those first :)

## Introduction

## Recursion

A function is `recursive` when it calls itself.

One key difference between a function call and a loop is that calling a function pushes the address to be returned to the stack.
This means that a recursive function usually demands more stack space than an equivalent loop.

As a consequence, a function which keeps calling itself may eventually exhaust all stack space.
This is called a **stack overflow**.

This is why every recursive function must have at least one base case, which is a situation when the function returns without calling itself.
Any recursive call must eventually reach a base case.

For example, the factorial function `n! = n * (n - 1) * ... * 1` can be defined recursively with `1` as the base case:

```x86asm
factorial:
    ; the argument `n` is passed on `rdi`
    ; the factorial will be returned on `rax`

    cmp rdi, 1
    jle .base_case     ; base case -> if rdi <= 1, return 1

    push rdi           ; save n
    dec rdi            ; rdi = n - 1
    call factorial     ; recursive call, rax = (n - 1)!
    pop rdi            ; restore n
    imul rax, rdi      ; rax = n * (n - 1)! = n!
    ret
.base_case:
    mov rax, 1
    ret
```

Note that `factorial` must `push rdi` before recursing and `pop rdi` after.
This is because it still needs `n` once the recursive call returns in order to compute `n * (n-1)!`.

This means each recursive call adds 16 bytes to the stack:

1. 8 bytes for the return address, pushed by `call`.
2. and another 8 bytes for the saved `rdi`.

The function will keeping adding those bytes to the stack until it reaches its base case.
Only then does it begin to unwind, with each stack frame doing its `pop rdi` and `ret`.

### Tail Call

In some situations, a function does not perform any more work after calling another and before returning.

Consider, for example:

```x86asm
times_three:
    imul rax, rdi, 3
    ret

triple_of_square:
    imul rdi, rdi
    call times_three
    ret
```

The function `triple_of_square`:

- multiplies the passed argument (in `rdi`) by itself, getting its square;
- then it calls `times_three`, which returns three multiplied by the argument passed.

As a result, `triple_of_square` returns `3*x²`, where `x` is its argument, passed in `rdi`.

Note that no work is done in `triple_of_square` after calling `times_three`, the function simply returns.
In a situation like this, instead of using `call`, a function might use `jmp` and transfer execution to the called function:

```x86asm
times_three:
    imul rax, rdi, 3
    ret

triple_of_square:
    imul rdi, rdi
    jmp times_three
```

This is called a `tail call`.

The main advantage of a tail call is avoiding the extra cost of `call`.
A `call` pushes a return address onto the stack, and for control to come back to that point there must be a matching `ret`.

A tail call skips both: there is no return address to push, and no extra `ret` to pair with, just the called function's own `ret`.

### Tail Recursion

A tail call is particularly useful for recursive functions that may call themselves many times before returning.

However, not every recursive call can be directly translated into a tail call.
As a `jmp` transfers control to the called function, the caller can not perform any more work after the tail call.

For example, the earlier `factorial` function is **not** tail recursive.
After the recursive call, it still needs to multiply the result with the current `n`, using `imul rax, rdi`.

In situations like this, it is sometimes possible to use an accumulator that will collect partial computations and be returned at the end.
For example, we can define a `factorial_helper` that does most of the work and then `factorial` sets up an accumulator and transfers control to `factorial_helper`:

```x86asm
factorial_helper:
    ; the argument `n` is passed on `rdi`
    ; `rax` is used as an accumulator and will be returned at the end

    cmp rdi, 1
    jle .base_case

    imul rax, rdi        ; we accumulate the partial result on `rax`
    dec rdi              ; rdi = n - 1
    jmp factorial_helper ; tail call to accumulate (n - 1)!
.base_case:
    ret                  ; returns the factorial already accumulated on `rax`

factorial:
    mov rax, 1           ; initial value for the accumulator
    jmp factorial_helper ; tail call
```

Since no more work is done after the recursive call, we do not need to save `rdi` anymore.
There is no `call` or `push rdi` and so each recursive iteration adds `0` bytes to the stack: no additional stack space is used.
This version can handle arbitrarily large `n` without overflowing the stack.
It is both more efficient and safer.

In some cases, with a manipulation of the order of the functions, even the `jmp` to the helper might be avoided.
For example, `factorial` and `triple_of_square` can be rewritten in this way:

```x86asm
factorial:
    mov rax, 1
factorial_helper:
    cmp rdi, 1
    jle .base_case

    imul rax, rdi
    dec rdi
    jmp factorial_helper
.base_case:
    ret

triple_of_square:
    imul rdi, rdi
times_three:
    imul rax, rdi, 3
    ret
```

In the snippet above, execution of `factorial` falls through to `factorial_helper`.
The same happens with `triple_of_square` and `times_three`.
In both cases, execution continues sequentially and it seems that the tail function is just a local label inside the "main" function.

In reality, there's no essential difference between any local label and a function.
x86-64 assembly does not give special treatment to any of them, they are just addresses in a section with executable code, such as `section .text`.

In this way, a tail recursive function can be thought of essentially the same as a loop where the recursive call jumps back to the top, and the base case is the condition that ends the loop.

## Instructions

Piper is an avid pie baker.

No one knows if she picked pie baking because of her name, or if she changed her name to match her hobby.
At a glance, the latter doesn't seem very likely, but you see, Piper is absolutely fascinated by pies.
She's always tinkering in the kitchen, tweaking her recipes, improving her craft, to the absolute delight of her friends.
Nothing escapes her attention to detail, not the temperature of her oven, not the weight of each ball of dough, and certainly not the shape of the pie itself.

Her latest interest?
Baking pies as circular as possible, to the point of mathematical perfection, with the help of her favorite number, you guessed it: π.

Piper found a delightful formula to calculate π iteratively, the Newton/Euler Convergence Transformation:

```c
π / 2 = sum for k from 0 to infinity of ( k! ) / ( 2 * k + 1 )!!
```

Help Piper get her kitchen in order, and bake her mathematically perfect pie.

## 1. Portion the dough

Piper rolled out two batches of dough this morning, with different weights (in `g`).
To keep her pies uniform, she wants to portion both batches into balls of the same weight.
And of course she wants the portions as large as possible to waste as little dough as possible!

The largest weight that divides both batches evenly is their **greatest common divisor**.
The Euclidean algorithm computes it recursively:

- `gcd(a, 0) = a` (base case)
- `gcd(a, b) = gcd(b, a mod b)`

Note that the recursive call sits in tail position: nothing happens after it.
Define `largest_portion` so that the recursive step is a `jmp` to the function itself, not a `call`.

```c
largest_portion(252, 105);
// => 21
```

Both arguments are 64-bit non-negative integers.
The return value is a 64-bit non-negative integer.

## 2. Double Factorial

You already know how to write the ordinary factorial in a tail recursive way from the concept.
The same function is in your stub file.

However, the Newton/Euler formula also uses **double factorials**, written `!!`.
The double factorial operator is defined as:

```c
0!! = 1
n!! = 1 * 3 * 5 * ... * n // if n is odd
n!! = 2 * 4 * 6 * ... * n // if n is even
```

Note that the double factorial follows the same pattern as the factorial, except it decrements by 2 at each step instead of 1.
Define the `double_factorial` function which will compute the double factorial in a tail recursive manner.

```c
double_factorial(5);
// => 15
double_factorial(6);
// => 48
```

The argument is a 32-bit unsigned integer.
The return value is a 64-bit unsigned integer.

## 3. Newton/Euler Convergence Transformation

Now Piper has every tool she needs.
Define the `pipers_pi` function, which approximates π using a set number of terms from the Newton/Euler Convergence Transformation formula:

```c
π / 2 = sum for k from 0 to infinity of ( k! ) / ( 2 * k + 1 )!!
```

The numerator uses the ordinary factorial.
You can call the `factorial` function already defined for you!
The denominator uses the `double_factorial` you wrote in task 2.

Let's compute the first term together.
For an upper limit of `0` (instead of infinity), we get:

```c
π / 2 ≈ sum for k from 0 to 0 of ( k! ) / ( 2 * k + 1 )!!
π / 2 ≈ (0!) / ( 2 * 0 + 1 )!!
π / 2 ≈ 0! / 1!!
π / 2 ≈ 1 / 1
π / 2 ≈ 1.0
π ≈ 2.0
```

For an upper limit of `2`, we get instead:

```c
π / 2 ≈ sum for k from 0 to 2 of ( k! ) / ( 2 * k + 1 )!!
π / 2 ≈ ((0!) / ( 2 * 0 + 1 )!!) + ((1!) / ( 2 * 1 + 1 )!!) + ((2!) / ( 2 * 2 + 1 )!!)
π / 2 ≈ 1 + (1! / 3!!) + (2! / 5!!)
π / 2 ≈ 1 + (1 / 3) + (2 / 15)
π / 2 ≈ 1.4666666
π ≈ 2.9333333
```

Each extra term will improve the approximation.

```c
pipers_pi(0);
// => 2.0
pipers_pi(1);
// => 2.6666666
pipers_pi(2);
// => 2.9333333
```

The argument is a 32-bit non-negative integer.
The return value is a 64-bit floating point number.

## Source

### Created by

- @oxe-i