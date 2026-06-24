section .rodata
colors: dd "blac", "brow", "red", "oran", "yell", "gree", "blue", "viol", "grey", "whit", 0, 0, 0, 0, 0, 0

section .text
global value
value:
    vmovdqu32 zmm1, [rel colors]
    vpcmpeqd k1, zmm1, [rdi]{1to16}
    vpcmpeqd k2, zmm1, [rsi]{1to16}
    kmovw eax, k1
    kmovw edx, k2
    tzcnt eax, eax
    tzcnt edx, edx
    lea eax, [eax + 4*eax]
    lea eax, [edx + 2*eax]
    ret

%ifidn __OUTPUT_FORMAT__,elf64
section .note.GNU-stack noalloc noexec nowrite progbits
%endif
