; constant and technique for divisibility of 25 taken from here: https://lemire.me/blog/2019/02/08/faster-remainders-when-the-divisor-is-a-constant-beating-compilers-and-libdivide/

C equ 0xFFFFFFFF/ 25 + 1

section .text
global leap_year
leap_year:
    imul esi, edi, C
    cmp esi, C - 1
    setbe al      ; divisible by 25
    test edi, 15
    setz cl       ; divisible by 16
    and cl, al
    test edi, 3
    setz dl       ; divisible by 4
    andn eax, eax, edx
    or al, cl
    movzx eax, al
    ret

%ifidn __OUTPUT_FORMAT__,elf64
section .note.GNU-stack noalloc noexec nowrite progbits
%endif
