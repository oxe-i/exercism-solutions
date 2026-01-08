section .text
global egg_count
egg_count:
    mov eax, -1
    mov edx, -1
    mov edi, edi
.count:
    inc eax
    inc edx
    shrx edi, edi, edx
    tzcnt edx, edi  
    jnc .count
    ret

%ifidn __OUTPUT_FORMAT__,elf64
section .note.GNU-stack noalloc noexec nowrite progbits
%endif
