section .text
global square
square:
    xor eax, eax
    mov edx, eax
    dec rdi
    bts rax, rdi
    cmp rdi, 64
    cmovae rax, rdx
    ret

global total
total:
    mov rax, -1
    ret

%ifidn __OUTPUT_FORMAT__,elf64
section .note.GNU-stack noalloc noexec nowrite progbits
%endif
