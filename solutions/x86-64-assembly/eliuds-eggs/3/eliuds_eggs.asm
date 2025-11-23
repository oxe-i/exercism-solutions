section .text
global egg_count
egg_count:
    xor eax, eax
    mov ecx, 32
.count:
    bt edi, ecx
    adc eax, 0
    loop .count
    ret

%ifidn __OUTPUT_FORMAT__,elf64
section .note.GNU-stack noalloc noexec nowrite progbits
%endif
