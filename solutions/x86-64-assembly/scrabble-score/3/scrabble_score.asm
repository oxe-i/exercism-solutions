section .rodata
scores: dd 0, 1, 3, 3, 2, 1, 4, 2, 4, 1, 8, 5, 1, 3, 1, 1, 3, 10, 1, 1, 1, 1, 4, 4, 8, 4, 10

section .text
global score
score:
    xor eax, eax
    lea rsi, [rel scores]
.accumulate:
    movzx edx, byte [rdi]
    inc rdi
    and edx, 31
    add eax, dword [rsi + 4*rdx]
    test edx, edx
    jnz .accumulate
    ret

%ifidn __OUTPUT_FORMAT__,elf64
section .note.GNU-stack noalloc noexec nowrite progbits
%endif
