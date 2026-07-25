section .rodata
precompute: 
dq 0x1111111111111111, 0x1111110111111111, 0x1111111111111111
dq 0x1111111111111011, 0x1111011111111111, 0x1111111111111111
dw 0x1111

section .text
global leap_year
leap_year:
    imul eax, edi, 0xFFFFFFFF / 400 + 1
    mov edx, 400
    mul edx
    xor eax, eax
    bt [rel precompute], edx
    setc al
    ret

%ifidn __OUTPUT_FORMAT__,elf64
section .note.GNU-stack noalloc noexec nowrite progbits
%endif
