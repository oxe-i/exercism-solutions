section .text
global egg_count
egg_count:
    xor eax, eax
    test edi, edi
    jz .done
align 16
.loop:
    inc eax
    blsr edi, edi
    jnz .loop
.done:
    ret

%ifidn __OUTPUT_FORMAT__,elf64
section .note.GNU-stack noalloc noexec nowrite progbits
%endif
