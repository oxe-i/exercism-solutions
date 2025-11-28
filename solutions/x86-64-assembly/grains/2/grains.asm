section .text
global square
square:
    xor rax, rax
    dec rdi
    cmp rdi, 64
    jae .exit
    bts rax, rdi
.exit:
    ret

global total
total:
    mov rax, -1
    ret

%ifidn __OUTPUT_FORMAT__,elf64
section .note.GNU-stack noalloc noexec nowrite progbits
%endif
