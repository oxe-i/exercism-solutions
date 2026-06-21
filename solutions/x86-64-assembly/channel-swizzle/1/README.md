# Channel Swizzle

Welcome to Channel Swizzle on Exercism's x86-64 Assembly Track.
If you need help running the tests or submitting your code, check out `HELP.md`.
If you get stuck on the exercise, check out `HINTS.md`, but try and solve it without using those first :)

## Introduction

## SIMD: Cross-Lane Operations

Every SIMD operation so far has acted _lane by lane_.
The value in lane `i` of the result is computed on the lane `i` of the inputs.

However, there are many situations when moving values between lanes is necessary or desired.
For example, the lanes may be out of order for the computation we need to perform.

There are many SIMD instructions that move data across lanes in different ways.

### Shuffling

A **shuffle** reorders the bytes or lanes of a register, drawing each destination lane from a source lane that may sit anywhere.
They can select the same lane to different destinations, which makes them capable of also broadcasting values.

The shuffling instructions behave differently according to their size and execution domain.

#### Selecting Lanes With an Immediate

The instruction `pshufd` rearranges the four 32-bit lanes of its source into its destination.

The selection is an 8-bit immediate, read as four 2-bit fields, one per destination lane.
Each field selects which of the four source lanes to copy into that destination lane:

| field | lane index |
|-------|------------|
| `00`  | `0`        |
| `01`  | `1`        |
| `10`  | `2`        |
| `11`  | `3`        |

The position of the field in the immediate, read right-to-left, indicates where the selected lane is inserted.
A source lane may be selected more than once, which is how a single lane is broadcast across the whole register:

```x86asm
; The bit fields are read right-to-left
pshufd xmm1, xmm0, 0b00_01_10_11 ; reverse: lane 0 takes source 0b11 (3), lane 1 takes source 0b10 (2), and so on
pshufd xmm3, xmm2, 0b00_00_00_00 ; broadcast source lane 0 into all four lanes
```

#### Shuffling Floating-Point Lanes

There are two floating-point shuffle instructions, following the same general syntax: `shuf` + `p` + the size suffix (either `s` or `d`).

They also use an immediate to select the lanes.
`shufps` uses the same 2-bit field encoding as the previous integer shuffles.
However, since there are only 2 64-bit lanes in a 128-bit operand, `shufpd` uses only a 1-bit field encoding.

These instructions differ from their integer counterparts in that they draw the lanes from _two_ operands rather than one:

- The low half of the result is taken from the destination operand.
- The high half is taken from the source operand.

```x86asm
shufps xmm0, xmm1, 0b11_10_01_00 ; xmm0 = {xmm0[0], xmm0[1], xmm1[2], xmm1[3]}
shufps xmm2, xmm3, 0b00_00_00_00 ; xmm2 = {xmm2[0], xmm2[0], xmm3[0], xmm3[0]}
shufpd xmm4, xmm5, 0b0_1         ; xmm4 = {xmm4[1], xmm5[0]}
```

Because both operands feed the result, they can be used to interleave two vectors in one step.
If both source and destination are the same register, every lane is drawn from it.

#### The Byte Shuffle

`pshufb` is the most general shuffle.
Even though `pshufb` and `pshufd` have very similar names, differing only on the size suffix, they perform very different operations.

First, while `pshufd` uses an immediate to select lane positions, `pshufb` uses a **control vector** in the source operand.
This control vector is a `xmm` register or a 16-byte memory operand.

For each of the 16 destination lanes, the low four bits of the control vector give a source byte index, 0 to 15.
If lane `i` of the control vector holds the source byte index `j`, then the `j-th` lane of the destination will be moved to the `i-th` lane.

This highlights a second difference between the two instructions.
While `pshufd` takes the shuffling lanes from a different source operand, `pshufb` performs the shuffling in-place in the destination.

```x86asm
section .rodata
align 16
reverse: db 15, 14, 13, 12, 11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1, 0

section .text
fn:
  pshufb xmm0, [rel reverse]
  ; xmm0[0] = xmm0[reverse[0]] (xmm0[15])
  ; xmm0[1] = xmm0[reverse[1]] (xmm0[14])
  ; ...
  ; in the end, the bytes in xmm0 are reversed
```

`pshufb` is even more flexible than that: it can clear any of the lanes.
If the top bit is set in a lane `i` of the control vector, then the lane `i` of the destination is zeroed-out.
This makes `pshufb` both an arbitrary byte permutation and a selective clear, in a single instruction.

Since `pshufb` acts on a byte granularity, it can also be used to shuffle lanes of different sizes, by grouping neighboring lanes together.
For example, it can be used to shuffle dwords:

```x86asm
section .rodata
align 16
input: dd 13, 25, 37, 49 ; each number takes 4 bytes
reverse_dwords: db 12, 13, 14, 15, 8, 9, 10, 11, 4, 5, 6, 7, 0, 1, 2, 3 ; aligned too, since input spans 16 bytes

section .text
fn:
  movdqa xmm0, [rel input] ; xmm0 = {13, 25, 37, 49}
  pshufb xmm0, [rel reverse_dwords]
  ; xmm0 = {49, 37, 25, 13}
```

### Interleaving Lanes

The **unpack** instructions take lanes from two operands and weave them together, alternating between the two.
There are integer and float variants and they largely follow the same general syntax structure, with two differences:

1. There is an `l` or `h` suffix to indicate if it acts on the low half (`l`) or the high half (`h`) of each operand.
2. The integer variants take two size suffixes, the second representing twice the first.
   For example, `bw` or `qdq` (the size suffix for 16 bytes is `dq`, as in `movdqu`).

```x86asm
punpcklwd xmm0, xmm1 ; p + unpck + l + wd
; this interleaves the first 4 words of xmm0 and xmm1 into 4 dwords
; for each dword in the result, the first word is taken from xmm0 and the second, from xmm1
; xmm0 = {xmm0[0], xmm1[0], xmm0[1], xmm1[1], xmm0[2], xmm1[2], xmm0[3], xmm1[3]}

unpckhps xmm2, xmm3 ; unpck + h + p + s
; this interleaves the high 32-bit floats of xmm2 and xmm3
; xmm2 = {xmm2[2], xmm3[2], xmm2[3], xmm3[3]}
```

### Narrowing With Saturation

The **pack** instructions run the other direction, combining the lanes of two operands into half-width lanes of the destination.

These instructions do not take a `p` prefix.
Other than that, the syntax combines elements we have already seen:

- the operation being performed, `pack`.
- an `s` or `u` to indicate if the output values are _signed_ or _unsigned_, respectively.
- an `s` for _saturating_, as in the saturating arithmetic seen in a previous concept.
- two size suffixes, the second indicating _half_ the width of the first (the opposite behavior to `unpck`).

Since the _pack_ operation is narrowing, it does not need an `l` or `h` suffix:

```x86asm
packssdw xmm0, xmm1 ; pack + s (for signed) + s (for saturating) + dw (dword to word)
packuswb xmm2, xmm3 ; pack + u (for unsigned) + s (for saturating) + wb (word to byte)
```

These instructions are **saturating**, i.e., the output values are clamped to the narrower range.
They operate from dword to word and from word to byte.
There is no qword to dword variant.

Note that the input is always interpreted as signed.
The type, either signed or unsigned, is for the _output_.
It indicates the range to be clamped.
For example, `packsswb` clamps to the range of a signed byte, i.e., `[-128, 127]`.

The low lanes of the result come from the destination operand and the high lanes from the source:

```x86asm
packusdw xmm0, xmm1   ; 8 words, each clamped to 0..65535
; xmm0 = {xmm0[0], xmm0[1], xmm0[2], xmm0[3], xmm1[0], xmm1[1], xmm1[2], xmm1[3]}
```

There is no floating-point equivalent for these instructions.

### Moving Individual Lanes

Until now, we have always moved data between a SIMD register and a general-purpose register using `movq`/`movd`.
These instructions can only write to, or read from, the low lane of a SIMD register, and, when writing, they clear all other lanes.

There are instructions that do the same for any lane, not only the first, leaving other lanes untouched:

- the **insert** instructions write one element from a general-purpose register, or memory, into a lane chosen by an immediate.
- the **extract** instructions read from one lane out into a general-purpose register.

Both follow the integer syntax: `p` + `insr`/`extr` + the size suffix (`b`, `w`, `d`, or `q`).

In both cases, the general-purpose register is usually 32-bit wide.
Only `pinsrq` and `pextrq` need a 64-bit operand.
A memory operand is always of the size of the operation: 8-bit for `pinsrb/pextrb`, 16-bit for `pinsrw/pextrw`, and so on.

```x86asm
pinsrb xmm0, eax, 5        ; replace byte 5 of xmm0 with the low byte of eax
pextrb byte [rdx], xmm0, 5 ; copy byte 5 of xmm0 into the memory location indicated by rdx
```

Note that these instructions, much like `movd` and `movq`, simply move raw bytes.
This means they can also be used for floating-point values stored in memory or in a general-purpose register.

## Instructions

You write the inner loops of a software image pipeline, the stage that prepares textures and composites layers before they reach the screen.
The pipeline works on pixels a block at a time, applying the same operation across the whole block.

A pixel is composed of four 1-byte channels: red, green, blue, and alpha, in that order (`RGBA`).
A block is 4 pixels, so 16 bytes in total.

You have five tasks.

You receive the operands through memory addresses, and you write your answer through a result address.
All memory addresses in this exercise are 16-byte aligned.

~~~~exercism/note
The computations in this exercise should be performed using SIMD instructions, not scalar operations.
~~~~

## 1. Convert an image to display order

Textures are stored as `RGBA`, but the framebuffer this pipeline draws into expects each pixel in `BGRA` order: the red and blue channels swapped, the green and alpha channels left in place.
An image arrives as a sequence of blocks, and every block is converted the same way.

Implement the `to_display_order` function, which converts a whole image from `RGBA` to `BGRA`, one block at a time.
You should define the channel-reordering control mask as a packed constant in memory, and reuse it for every block.

This function takes as arguments, in this order:

- `result`: memory address for a buffer where the converted blocks are written, 16 bytes per block.
- `pixels`: memory address of the source blocks, 4 pixels per block, each pixel 4 bytes in `RGBA` order.
- `block_count`: the number of blocks, always greater than `0`.

```c
pixels      = {200, 64, 32, 255, 10, 20, 30, 40, 0, 0, 0, 255, 12, 34, 56, 78,
               1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16} // 2 blocks
block_count = 2
result      = {32, 64, 200, 255, 30, 20, 10, 40, 0, 0, 0, 255, 56, 34, 12, 78,
               3, 2, 1, 4, 7, 6, 5, 8, 11, 10, 9, 12, 15, 14, 13, 16}
```

This function has no return value.

## 2. Fill a region with one color

To clear a region or paint a flat span, the pipeline writes a single color across every pixel of the region.

Implement the `fill_region` function, which fills a region of `block_count` blocks with copies of one color.

This function takes as arguments, in this order:

- `result`: memory address for a buffer where the filled blocks are written, 16 bytes per block.
- `color`: memory address of one pixel, 4 bytes in `RGBA` order.
- `block_count`: the number of blocks to fill, always greater than `0`.

```c
color       = {18, 52, 86, 120}
block_count = 2
result      = {18, 52, 86, 120, 18, 52, 86, 120, 18, 52, 86, 120, 18, 52, 86, 120,
               18, 52, 86, 120, 18, 52, 86, 120, 18, 52, 86, 120, 18, 52, 86, 120}
```

This function has no return value.

## 3. Weave two scanlines

Two single-channel layers need to be merged into one buffer with their samples interleaved.
The result alternates one sample from the first layer, then one from the second.

Implement the `weave_scanlines` function, which interleaves two rows of 16 samples each into a single row of 32 samples.

This function takes as arguments, in this order:

- `result`: memory address for a buffer where the 32 interleaved samples are written.
- `first`: memory address of the first row, 16 samples, each an 8-bit value.
- `second`: memory address of the second row, 16 samples, each an 8-bit value.

```c
first  = {0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15}
second = {100, 101, 102, 103, 104, 105, 106, 107, 108, 109, 110, 111, 112, 113, 114, 115}
result = {0, 100, 1, 101, 2, 102, 3, 103, 4, 104, 5, 105, 6, 106, 7, 107,
          8, 108, 9, 109, 10, 110, 11, 111, 12, 112, 13, 113, 14, 114, 15, 115}
```

This function has no return value.

## 4. Pack a brightened row

A brightness pass scales each sample in 16-bit working precision, so that an over-bright sample can exceed `255` and a difference can drop below `0`.
The final stage narrows those working values back to 8-bit samples for display, clamping anything below `0` up to `0` and anything above `255` down to `255`.

Implement the `pack_samples` function, which narrows two groups of 8 working values into one row of 16 samples, in order.

This function takes as arguments, in this order:

- `result`: memory address for a buffer where the 16 clamped samples are written, each an 8-bit value.
- `first`: memory address of the first 8 working values, each a 16-bit signed integer.
- `second`: memory address of the next 8 working values, each a 16-bit signed integer.

```c
first  = {300, -5, 128, 255, 0, 400, 64, 200}
second = {255, 256, -1, 100, 50, 1000, 7, 0}
result = {255, 0, 128, 255, 0, 255, 64, 200,   255, 255, 0, 100, 50, 255, 7, 0}
```

This function has no return value.

## 5. Split coordinates into x and y

Texture and vertex data often arrives interleaved, each point's `x` and `y` packed together.
However, it is often necessary to have them apart for efficient processing: all the `x` values in one vector, all the `y` values in another.

Implement the `split_coordinates` function, which separates four interleaved `(x, y)` points into a vector of `x` coordinates and a vector of `y` coordinates.

This function takes as arguments, in this order:

- `xs`: memory address for a buffer where the 4 `x` coordinates are written, 4 32-bit floating-point numbers.
- `ys`: memory address for a buffer where the 4 `y` coordinates are written, 4 32-bit floating-point numbers.
- `first`: memory address of the first two points, 4 32-bit floating-point numbers, as `{x0, y0, x1, y1}`.
- `second`: memory address of the next two points, 4 32-bit floating-point numbers, as `{x2, y2, x3, y3}`.

```c
first  = {0.0, 0.5, 1.0, 1.5} // {x0, y0, x1, y1}
second = {2.0, 2.5, 3.0, 3.5} // {x2, y2, x3, y3}
xs     = {0.0, 1.0, 2.0, 3.0} // {x0, x1, x2, x3}
ys     = {0.5, 1.5, 2.5, 3.5} // {y0, y1, y2, y3}
```

This function has no return value.

## Source

### Created by

- @oxe-i