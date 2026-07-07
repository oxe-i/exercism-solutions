# Opening Night

Welcome to Opening Night on Exercism's x86-64 Assembly Track.
If you need help running the tests or submitting your code, check out `HELP.md`.
If you get stuck on the exercise, check out `HINTS.md`, but try and solve it without using those first :)

## Introduction

## Atomics

A single instruction can look like one indivisible action while being nothing of the sort.
Take adding five to a value in memory:

```x86asm
add qword [rel counter], 5
```

Underneath, the processor does not have a way to add to memory directly.
It breaks this one instruction into three smaller steps, called **micro-operations**:

1. **read** the current value from memory;
2. **modify** this value in a register, adding five to it;
3. **write** the result back.

```x86asm
mov rax, qword [rel counter] ; 1. load the current value
add rax, 5                   ; 2. add five
mov qword [rel counter], rax ; 3. store the result back
```

This is a common pattern called **read-modify-write (RMW)**.

Note that the read (or load) and the write (or store) are separate events, so there is a window of time between them.
We usually do not notice this because on a single core each instruction is guaranteed to produce its effect in full before the next one.
That window is therefore invisible and `add` behaves as a single unit.

However, modern CPUs are rarely single-core, and applications often run on many cores at once, with no sequencing between them.
With several cores running at the very same instant, another core can read or write `counter` inside the window, after this core's load and before its store.
Two threads each load the same old value, each add five, and each store their result.
Two additions happened, but the value only moved by five.
One update was silently lost.

This is a **data race**, and it is a common issue in multi-threaded code.

Not every value is exposed this way.
Each thread has its own registers and its own stack, so a value held in a register, or a local variable on a thread's stack, is exclusive to that thread and cannot race.
Only the memory the threads share, like `counter` above, needs protecting.

x86-64 offers a set of instructions to solve this problem, by making an instruction indivisible.
It behaves as a single unit not only for the core that processes it, but for every other core as well.
An operation that holds together, that no other core can split, is called **atomic**.

~~~~exercism/note
It is common to refer to applications that run on many cores as multi-threaded.
However, a **thread** is not the same as a core.
Two threads may run concurrently on the same core, interleaving with each other, or in parallel on different cores.

Interleaving threads can already race across a read-modify-write if it is split into multiple instructions, since the OS can switch threads between any two instructions.
The window inside a _single_ instruction, however, is only exposed by true parallel code.
Because the OS only switches threads between instructions, never inside one, a single instruction is inherently safe on a single core.

True atomicity across _multiple_ cores is what the instructions below provide.
~~~~

### Atomic Exchange

The `xchg` instruction swaps two operands.
The destination operand becomes equal to the previous value in the source operand, while the source operand becomes equal to the previous value in the destination operand.
Conceptually, it can be thought of as two `mov` instructions happening at once.

As usual, it can be used with two register operands or with one memory operand and one register operand:

```x86asm
mov  eax, 1
xchg dword [rdi], eax ; [rdi] = 1, eax = the old value of [rdi]
mov ecx, 2
mov edx, 3
xchg edx, ecx         ; edx = 2, ecx = 3
```

When used with a memory operand, `xchg` is _always_ atomic.

~~~~exercism/caution
`xchg` is automatically atomic when one of the operands is a memory location.
This also means the operation is much slower in that situation.

If you do not need atomicity, do the swap through a spare register with plain `mov` instructions instead.
~~~~

### The Lock Prefix

The most common way an instruction can be made atomic in x86-64 is by adding the `lock` prefix.
It fuses the read, the modify, and the write into one indivisible step.
This means the core holds the memory exclusively throughout the whole process, so no other core can read or write that location in between.

```x86asm
lock add qword [rel counter], 5 ; the read, the modify, and the write are one step
```

`lock` only works when the destination is memory, and only on instructions that read-modify-write that memory:

1. arithmetic operations, such as `add`, `sub`, `inc`, `dec`, `neg`;
2. bitwise operations, such as `and`, `or`, `xor`, `not`;
3. the bit operations `bts`, `btr`, `btc`;
4. some other dedicated instructions, such as `xadd` and `cmpxchg`, described below.

~~~~exercism/caution
Holding a location exclusively and keeping every other core out is not free.
A `lock`-prefixed operation is markedly slower than its plain form, and slower still when several cores contend for the same location.

This prefix should be reserved for memory that is expected to be mutated by more than one thread.
Avoid using it if the memory is not shared or if it is only ever read.
~~~~

### Exchange and Add

A plain `lock add` updates memory but throws the old value away.
Often the old value is exactly what is wanted, for example to hand each thread a distinct ticket number.

The `xadd` instruction (`x` for exchange) returns the previous value while it adds.
It writes the sum into the destination and leaves the original destination value in the source register.

```x86asm
mov  rax, 1
lock xadd qword [rdi], rax ; [rdi] = [rdi] + rax = [rdi] + 1
                           ; rax = the old value of [rdi]
```

With the `lock` prefix this is an atomic **fetch-and-add**.
Run by many threads on the same counter, each call returns a different old value.

As with `lock add`, the counter ends at the exact number of calls.
However, unlike `lock add`, every intermediate value is returned too, one to each caller.

### Compare and Exchange

`xadd` adds and `xchg` overwrites, but neither can make the new value depend on the current one and apply it only if nothing changed underneath.
That conditional update is what `cmpxchg`, compare-and-exchange, provides, and it is the most general of these primitives.

`cmpxchg dest, src` uses `rax` as an implicit accumulator, and compares it against `dest`:

- If `dest == rax`, `dest = src` and `ZF = 1`.
- If `dest != rax`, `rax = dest` and `ZF = 0`.

Note that `dest` is only updated when it is equal to the expected value, previously loaded into `rax`.
This equality ensures `dest` still holds the value the new one was computed from, so an update based on a stale read is never applied.
That makes `cmpxchg` the building block for an atomic update, also known as **compare-and-swap (CAS)**:

```x86asm
    mov rax, qword [rdi]          ; rax = the value we expect to find
.retry:
    lea rcx, [rax + 10]           ; rcx = the new value we want to install
    lock cmpxchg qword [rdi], rcx ; if [rdi] still equals rax, store rcx and set ZF
                                  ; otherwise reload rax with the current value, clear ZF
    jnz  .retry                   ; ZF is cleared, so another thread won the race. Recompute and retry
```

This **retry loop** is the heart of lock-free updates.
The window between the read and the compare-and-exchange is exactly when another thread might intervene, and `cmpxchg` catches that by refusing to store a value computed from a stale read.

### Memory Ordering

Every operation so far has touched a single location.
When threads coordinate through more than one location, a new question appears: in what order does one thread's writes become visible to another.
The rules that answer this question are the processor's **memory ordering**.

The branchless-code concept introduced the idea that a modern core does not plod through instructions one at a time.
It keeps many in flight at once and runs ahead where it can.
This means a write may become visible to the other cores later than the program suggests, while instructions after it have already gone ahead.

x86-64 keeps a **strong memory ordering** among ordinary loads and stores, so that on each core:

1. a load is never reordered after a later load;
2. a store is never reordered after a later store;
3. a load is never reordered after a later store.

The only possible reordering is a store appearing to complete after a later load of a _different_ address.

A `lock`-prefixed instruction, or an `xchg` with a memory operand, is a full barrier: nothing appears to move across it in either direction.
This is why they are enough to ensure full ordering in most situations.

### Spinning and `pause`

Instructions that set a flag while also returning its previous state are known as **test-and-set**.
They may be used as the basis of a **spinlock**, ensuring a core has exclusive access to some part of the code.

This is the overall algorithm, using the `xchg` instruction with a binary flag:

1. The flag starts as `0`.
2. To acquire the lock, a core swaps the value in the flag with `1`.
3. If the returned value is `1`, this means the lock is _held_ by another core.
   The current core then waits and tries acquiring the lock again.
4. If the returned value is `0`, this means the lock was free.
   `xchg` has now set it to `1`, and other cores will wait until this core releases it.
5. Once the current core finishes working, updating the flag with `0` releases the lock.

```x86asm
acquire:
    mov  eax, 1
    xchg dword [rdi], eax ; try to take the lock; eax = its old value
    test eax, eax
    jnz  .held            ; old value was 1: someone else holds it
    ret                   ; old value was 0: the lock is ours
.held:
    pause                 ; wait before trying again
    jmp  acquire
```

The `pause` instruction in the wait loop does not change what the code computes.
It hints to the processor that this is a spin-wait.
The CPU can then reduce power use on the waiting thread and yield to a sibling thread sharing the same core.
A spin loop without `pause` is still correct, only wasteful.

Once the thread finishes its work, it may release the lock with a plain store of `0` using `mov`.
Nothing more than a `mov` is needed, because on x86-64 loads and stores are never reordered after a later store.
A store that never overtakes the accesses before it is said to have **release ordering**, and on x86 every plain store carries it.

~~~~exercism/note
Any instruction that atomically tests and sets a memory location may be used for a spinlock.
For example, `lock bts` may be used instead of `xchg`, to set a specific bit while checking if it was already set.

Note that flags, such as the `CF` modified by `bts`, are part of `rflags`, a register.
This means they are exclusive to each thread.
~~~~

## Instructions

It is opening night at the Grand Marquee, and the whole staff is working at once.
The crowd pours in through every door, several box-office windows sell from the same ticket roll, the premiere is close to selling out, and up in the projection booth the reels have to keep moving.

Everything the staff shares lives at a memory address, and the tests call your functions from several threads at the same time.
A value that is read, changed, and written back in separate steps will lose updates under that load, so each function must make its update atomic.

All shared values in this exercise are 64-bit signed integers.

You have five tasks.

~~~~exercism/note
The updates in this exercise should be performed with _atomic_ instructions.
The tests run your functions concurrently and check that no update is lost, so a non-atomic read-modify-write is very likely to fail them.
~~~~

## 1. Count the admissions

The doors are open, and at every one of them an usher is tearing tickets.
Each group let through is counted into one shared admissions tally, and with every door counting at once, the house count must still come out true.

Implement the `admit_group` function, which atomically adds the size of a group to the tally.

This function takes as arguments, in this order:

- `admissions`: memory address of the shared admissions tally, a 64-bit signed integer.
- `group_size`: the number of people in the group, a 64-bit signed integer, always greater than `0`.

```c
admissions = 120, group_size = 4
// admissions is now 124
```

The tests admit groups through several doors at once.
The final tally must equal the sum of every group let through.

This function has no return value.
The tally should be updated in-place.

## 2. Change the reel

The projector mounts exactly one reel.
Mounting the next reel and taking out the current one must be a single motion: with two projectionists at the machine, two separate steps could hand the same reel to both of them, or drop one on the floor.

Implement the `change_reel` function, which atomically mounts the next reel and returns the one that was mounted.

This function takes as arguments, in this order:

- `mounted`: memory address of the identifier of the mounted reel, a 64-bit signed integer.
- `next_reel`: the identifier of the reel to mount, a 64-bit signed integer.

```c
mounted = 7, next_reel = 9
// => 7, and mounted is now 9
```

This function returns the identifier of the previously mounted reel as a 64-bit signed integer.
The tests have several threads swap reels through the same mount at once, and check that every reel handed in comes back out exactly once.

## 3. Sell a ticket

Every window sells from one shared count of tickets sold.
Adding to a count, as the doors do, is not enough here: each sale must also learn the number it was given.
No two sales may share a number, and after the rush the count must equal the number of tickets sold, exactly.

Implement the `sell_ticket` function, which atomically adds one to the count and returns the number of the ticket just sold.
The ticket number is the count _after_ this sale: when the count was `41`, this sale is ticket `42`.

This function takes as an argument:

- `tickets_sold`: memory address of the shared count of tickets sold, a 64-bit signed integer.

```c
tickets_sold = 0
// => 1, and tickets_sold is now 1

tickets_sold = 41
// => 42, and tickets_sold is now 42
```

This function returns the ticket number as a 64-bit signed integer.
The tests sell from several windows at once: every returned number must be distinct, and the final count must equal the number of sales.

## 4. Fill the premiere

The premiere has a fixed number of seats, and every window is selling it.
A sale may only go through while a seat remains, and the screening must never oversell, not even when every window grabs for the last seat in the same instant.
Checking the count and then adding to it as two separate steps leaves a window in between, so the check and the update must succeed or fail together.

Implement the `claim_seat` function, which atomically claims the next seat when one is still free.
When a seat is claimed, the function returns the seat's number, which is the count of taken seats after this claim.
When the screening is sold out, it returns `0` and leaves the count unchanged.

This function takes as arguments, in this order:

- `seats_taken`: memory address of the count of seats already taken, a 64-bit signed integer, never above `capacity`.
- `capacity`: the number of seats in the screening, a 64-bit signed integer, always greater than `0`.

```c
seats_taken = 0, capacity = 150
// => 1, and seats_taken is now 1

seats_taken = 82, capacity = 150
// => 83, and seats_taken is now 83

seats_taken = 149, capacity = 150
// => 150, and seats_taken is now 150

seats_taken = 150, capacity = 150
// => 0, and seats_taken stays 150
```

This function returns the seat number, or `0` when the screening is sold out, as a 64-bit signed integer.

## 5. Mind the booth

The projection booth fits one person.
A word in memory says whether it is occupied: `0` for free, `1` for occupied.
Staff come by all night, each with a task to do inside: sign the logbook, thread the projector, file a reel.
Whatever the task, the booth's rule is the same, and enforcing it is your job: one person inside at a time, from the start of their task to its end.

Implement the `visit_booth` function, which:

1. waits until the booth is free;
2. claims the booth;
3. runs the visitor's task;
4. reopens the booth after the task and before returning.

While the booth is held by someone else, it should wait politely with `pause`.

This function takes as arguments, in this order:

- `booth`: memory address of the occupancy word, a 64-bit signed integer that is either `0` or `1`.
- `task`: the visitor's task, a function that takes no parameters and has no return value.

Note the tests run tasks that look at the booth and at a shared logbook.
This means the booth must be occupied for the whole task, every visit must run its task exactly once, and with several visitors at once the logbook must come out exact.

~~~~exercism/caution
The visitor's task is an ordinary function that follows the calling convention:

- it may overwrite any caller-saved register, so you should keep anything you still need after the task somewhere the call cannot touch;
- it also expects the stack to be 16-byte aligned at the point of the call.

A violation of either rule may surface as a crash rather than a failed check.
~~~~

## Source

### Created by

- @oxe-i