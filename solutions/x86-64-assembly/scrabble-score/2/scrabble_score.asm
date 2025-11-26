section .rodata
    scores dd 1, 3, 3, 2, 1, 4, 2, 4, 1, 8, 5, 1, 3, 1, 1, 3, 10, 1, 1, 1, 1, 4, 4, 8, 4, 10

section .text
global score
score:
    xor eax, eax
    lea rsi, [rel scores]
.accumulate:
    movzx rdx, byte [rdi]
    test rdx, rdx
    jz .end
    and rdx, 31
    add eax, dword [rsi + 4*rdx - 4]
    inc rdi
    jmp .accumulate
.end:
    ret

%ifidn __OUTPUT_FORMAT__,elf64
section .note.GNU-stack noalloc noexec nowrite progbits
%endif
