section .rodata
   align 64
   colors dd "blac", "brow", "red", "oran", "yell", "gree", "blue", "viol", "grey", "whit"
   times 24 db 0

section .text
global value
value:
    vmovdqa32 zmm1, [rel colors]
    vpbroadcastd zmm2, [rdi]
    vpbroadcastd zmm3, [rsi]
    vpcmpeqd k1, zmm1, zmm2
    vpcmpeqd k2, zmm1, zmm3
    kmovw eax, k1
    kmovw edx, k2
    tzcnt eax, eax
    tzcnt edx, edx
    lea eax, [eax + 4*eax]
    shl eax, 1
    add eax, edx
    ret

%ifidn __OUTPUT_FORMAT__,elf64
section .note.GNU-stack noalloc noexec nowrite progbits
%endif
