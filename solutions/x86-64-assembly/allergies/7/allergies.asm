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
    mov rax, 0x0706050403020100     
    vmovq xmm0, rax
    vpmovzxbd ymm0, xmm0
    vpcompressd [rsi + 4]{k1}, ymm0 
    vzeroupper
    ret

%ifidn __OUTPUT_FORMAT__,elf64
section .note.GNU-stack noalloc noexec nowrite progbits
%endif
