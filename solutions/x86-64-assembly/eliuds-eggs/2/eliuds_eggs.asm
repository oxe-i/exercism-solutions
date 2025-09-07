section .text
global egg_count
egg_count:
    xor eax, eax
    %assign i 0
%rep 32
    bt edi, i
    adc eax, 0
    %assign i i+1
%endrep
    ret

%ifidn __OUTPUT_FORMAT__,elf64
section .note.GNU-stack noalloc noexec nowrite progbits
%endif
