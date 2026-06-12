section .text
global allergic_to
allergic_to:
    ; edi - enum item for allergy
    ; esi - score
    ; output in eax

    bt esi, edi
    setc al
    movzx eax, al
    ret

global list
list:
    ; edi - score
    ; rsi - pointer to item_list struct
    ; struct has one int size and
    ; one array of enum items
    ; struct is modified in place

    and edi, 0xFF
    popcnt eax, edi
    mov [rsi], eax              
    kmovw k1, edi                 
    mov rax, 0x0706050403020100
    vmovq xmm0, rax
    vpmovzxbd ymm0, xmm0            
    vpcompressd ymm0 {k1}{z}, ymm0 
    vmovdqu [rsi + 4], ymm0 
    ret

%ifidn __OUTPUT_FORMAT__,elf64
section .note.GNU-stack noalloc noexec nowrite progbits
%endif
