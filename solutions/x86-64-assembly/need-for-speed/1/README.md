# Need For Speed

Welcome to Need For Speed on Exercism's x86-64 Assembly Track.
If you need help running the tests or submitting your code, check out `HELP.md`.
If you get stuck on the exercise, check out `HINTS.md`, but try and solve it without using those first :)

## Introduction

## Interfacing with the C language: Structs

In the C language, a **struct** is a composite type, formed of different fields.
Each field has its own type and size.

For instance, this defines a type formed of three integers, two of 4 bytes and one of 8 bytes:

```c
struct example {
    int32_t first_four_byte_integer;
    uint32_t second_four_byte_integer;
    uint64_t eight_byte_integer;
};
```

A struct may also contain other structs:

```c
struct example_2 {
    struct example first;
    struct example second;
};
```

If one of the struct's fields is an array, all bytes allocated for the array are part of the struct.
However, if the field is only a pointer to the array, then the array must be stored somewhere else:

```c
struct with_array {
    char string[20];
};
// all 20 bytes of string are inside struct with_array

struct with_pointer {
    const char *string;
};
// only the 8-byte pointer to the string is inside struct with_pointer
```

### Alignment

The **alignment** of a type is a non-negative power of two (1, 2, 4, 8, ...) that represents a requirement on its address.
Every object of that type must be located in an address that is a multiple of its alignment.

For a primitive type, the alignment is usually equal to its size, so, for instance, a `int32_t` usually has 4-byte alignment.
This means that `int32_t` must be allocated at 4-byte boundaries.

A struct's alignment, however, is the maximum alignment of any of its fields.
So, for example, the `struct example`, defined above, would have an alignment of 8 bytes, since this is the alignment of `uint64_t`.

If a struct field's alignment is smaller than the struct's, padding bytes may be inserted after that field.
This ensures that the following fields and the struct as a whole meet alignment requirements.
In practice, this means that although those padding bytes contribute to the struct's size, they are not used in the value of the struct:

```c
struct example_3 {
    char one_byte; // alignment of 1
    int four_byte; // alignment of 4
};
// example_3 has alignment of 4 (the same as int)
// it occupies 8 bytes in space:
// 1 byte for field 'one_byte'
// 3 padding bytes (with undefined value)
// 4 bytes for field 'four_byte'
```

Note that in the struct defined above, field 'one_byte' has alignment of 1 and can be placed at any address.
Since field 'four_byte' has alignment of 4, fields in the struct must also respect 4-byte boundaries.
This means that there must be a number of bytes that is multiple of 4 between any two fields in the struct.
Since 'one_byte' occupies only 1 byte, then 3 padding bytes are inserted after it to respect this boundary.

Adjacent fields are grouped whenever possible in order to minimize the number of padding bytes necessary:

```c
struct two_padding {
    char one; // alignment of 1
    char two; // alignment of 1
    int three; // alignment of 4
};
// struct two_padding has alignment of 4 (the same as int)
// it occupies 8 bytes in space:
// 1 byte for field 'one'
// 1 byte for field 'two'
// 2 padding bytes
// 4 bytes for field 'three'
```

This grouping must also respect the alignment of each field:

```c
struct one_padding {
    char one; // alignment of 1
    int16_t two; // alignment of 2
    int three; // alignment of 4
};
// struct one_padding has alignment of 4 (the same as int)
// it occupies 8 bytes in space:
// 1 byte for field 'one'
// 1 padding byte
// 2 bytes for field 'two'
// 4 bytes for field 'three'
// Since 'two' has alignment of 2, it must be placed in a 2-byte boundary
// So, there must be 1 padding byte between 'one' and 'two'
```

This means that changing the order of fields in a struct can sometimes lead to a difference in its size:

```c
struct example_4 {
    int64_t one;
    short two;
    int32_t three;
};
// example_4 has alignment of 8 (the same as int64_t)
// it occupies 16 bytes in space:
// 8 bytes for field 'one'
// 2 bytes for field 'two'
// 2 padding bytes
// 4 bytes for field 'three'
// two' and 'three' are adjacent and can be grouped to sum up 8 bytes with only 2 bytes of padding

struct example_5 {
    int16_t one;
    int64_t two;
    unsigned int three;
};
// example_5 also has alignment of 8 (the same as int64_t)
// however, it occupies 24 bytes in space:
// 2 bytes for field 'one'
// 6 bytes for padding
// 8 bytes for field 'two'
// 4 bytes for field 'three'
// 4 padding bytes
// 'one' can't be grouped with 'two' because their sum would be higher than the struct's alignment
// 'two' and 'three' also can't be grouped, for the same reason
// so padding bytes must be inserted in full after each field with less than 8 bytes in alignment
```

Note that the alignment of an array is the same as the alignment of its underlying type:

```c
struct array_example {
    char string[10]; // alignment of 1
};
// array_example has alignment of 1 (it can be placed at any address)
// it occupies 10 bytes in space, one for each char in 'string'
```

Elements of an array can be grouped in the same way as if they were not part of an array:

```c
struct group_array {
    int16_t arr[3];
    int8_t one_byte;
    int32_t four_byte;
};
// group_array has alignment of 4 because this is the alignment of 'four_byte'
// it occupies 12 bytes in space:
// 4 bytes for arr[0] and arr[1]
// 2 bytes for arr[2]
// 1 byte for 'one_byte'
// 1 padding byte (arr[2] is grouped with 'one_byte')
// 4 bytes for 'four_byte'
```

It is important to account for any possible padding bytes whenever accessing a struct in assembly.

### Calling convention

In general, values are passed to, and returned from, functions as one should expect:

- Integer values, including memory addresses and enums, are passed in General-Purpose Registers (GPR).
- Floating-point values are passed in `xmm` registers.

Structs, however, are a special case.
As a rule of thumb, all fields in a struct occupy adjacent space in memory and should be placed in a single register whenever possible:

```c
struct single_type {
    int16_t first;
    int16_t second;
    int16_t third;
    int16_t fourth;
};
// this struct occupies 8 bytes
// it is entirely passed in the same GPR register:
// the field 'first' is passed on the lowest 2 bytes
// each subsequent field is passed in the following 2 bytes
```

If a struct has fields with integer values and also fields with floating-point values, each consecutive 8-byte in the struct should be classified separately:

```c
struct mixed_types {
    double first;
    int second;
    int third;
};
// this struct occupies 16 bytes
// the field 'first' is passed in the first 8 bytes of a xmm register
// the fields 'second' and 'third' are passed in the same GPR register:
// the field 'second' is passed on the lowest 4 bytes
// the field 'third' is passed in the next 4 bytes
```

In case integers and floating-point values are in the same 8-byte, the type is integer and the entire 8-byte (including the floating-point value) is placed in a GPR:

```c
struct mixed_types {
    int32_t integer;
    float floating_point;
};
// this struct occupies 8 bytes
// it is entirely passed in the same GPR register:
// the field 'integer' is passed on the lowest 4 bytes
// the field 'floating_point' is passed on the next 4 bytes
```

~~~~exercism/caution
When a conversion is made from a floating-point to an integer using `cvtsi2ss` or `cvtsi2sd`, this changes the organization of the underlying bytes.

You can use `movd` (for 32-bit values) and `movq` (for 64-bit values) to move raw bytes from a `xmm` register to a GPR, without changing bit representation.
~~~~

However, structs with more than 16 bytes in size are usually placed in memory, regardless of the type of each 8-byte:

```c
struct big_struct {
    uint8_t first;
    double second;
    int64_t third;
};
// this struct occupies 24 bytes, including 7 padding bytes between 'first' and 'second'
// it is entirely passed in memory
```

When a struct is passed as argument to a function, it uses as many registers as necessary.
If it is placed in memory, the stack is used instead.

Similar rules apply to structs returned from a function.
They are usually returned first in `rax` and `rdx` (if of integer value) or `xmm0` and `xmm1` (if of floating-point value).
If placed in memory, however, the caller must reserve space for it and pass the address to this memory location as an implicit first argument to the function (in `rdi`).
The function then stores the struct in this space and returns its address in `rax`.

## Instructions

In this exercise you'll be organizing races between various types of remote controlled cars.
Each car has its own characteristics and runs on many different tracks in races throughout the tournament season.

~~~~exercism/note
The functions in this exercise are declared in a C source file with the provided signatures.
Your x86-64-assembly code must follow those specifications.
~~~~

## 1. Create a remote controlled car

You have defined a struct `car_t` to represent a remote controlled car:

```c
struct car_t {
    char name[10];
    int16_t speed;
    float battery;
};
```

Allow creating a remote controlled car by defining a function `new_car` in x86-64 assembly.
The field `battery` always starts with the value `100.0`.

```c
struct car_t new_car(short speed, const char name[]);
```

## 2. Create new track

Tracks are represented by a struct `track_t`:

```c
struct track_t {
    enum surface_t surface;
    size_t distance;
};
```

The `enum surface_t` keeps track of different surfaces for a track:

```c
enum surface_t {
    ASPHALT,
    SAND,
    ICE,
    CLAY
};
```

Allow creating a new track by defining a function `new_track` in x86-64 assembly.

```c
struct track_t new_track(enum surface_t surface, size_t distance);
```

## 3. Create a racing event

Up to 6 cars participate in each race, running some specified number of laps on a track.
Races are represented by a struct `race_t`:

```c
struct race_t {
    struct track_t track;
    uint8_t num_of_laps;
    struct car_t cars[6];
    uint8_t num_of_running_cars;
};
```

Define a function `new_race` in x86-64 assembly.
At the start, there are no confirmed participating cars for the race:

```c
struct race_t new_race(struct track_t track, uint8_t num_of_laps);
```

## 4. Confirm a car to the race

When a car's owner asks for it to participate in a race, its participation is only confirmed if the list is not already full.

Define a function `add_participant` in x86-64 assembly.
If there's room for one more participant in the race, the car is added to the list, updating the counter, and its participation is confirmed.
Otherwise, the race organizers must inform the car's owner that it can't participate this time.

```c
bool add_participant(struct race_t *race, struct car_t car);
```

## 5. Create a tournament

You keep track of races scheduled for the season in a struct `tournament_t`:

```c
struct tournament_t {
    struct race_t races[20];
    size_t num_of_races;
};
```

Define a function `add_race` in x86-assembly, to add a race to the tournament's array and also update its counter.
You may consider that there will always be enough space in the `races` array for the new race.

```c
void add_race(struct tournament_t *tournament, struct race_t race);
```

## Source

### Created by

- @oxe-i