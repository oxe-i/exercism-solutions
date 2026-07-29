section .rodata
align 32
allergens: dd 0, 1, 2, 3, 4, 5, 6, 7, 0, 0, 0, 0, 0, 0, 0, 0

section .text
global allergic_to
allergic_to:
    xor  eax, eax
    bt   esi, edi
    setc al
    ret

global list
list:
    and edi, 0xFF
    popcnt eax, edi
    mov dword [rsi], eax
    kmovd k1, edi
    vmovdqa ymm0, [rel allergens]
    vpcompressd [rsi + 4]{k1}, ymm0 
    vzeroupper
    ret

%ifidn __OUTPUT_FORMAT__,elf64
section .note.GNU-stack noalloc noexec nowrite progbits
%endif
