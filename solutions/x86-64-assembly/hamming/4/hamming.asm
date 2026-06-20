section .text
global distance
distance:
    vmovdqa xmm0, [rdi]
    vmovdqa xmm3, [rsi]
    vpxor xmm1, xmm1, xmm1
    vpcmpeqb xmm2, xmm1, xmm0
    vpcmpeqb xmm4, xmm1, xmm3
    vpcmpeqb xmm5, xmm0, xmm3
    vpcmpeqb xmm6, xmm2, xmm4
    vpcmpeqb xmm1, xmm1, xmm1
    vpxor xmm5, xmm5, xmm1
    vpmovmskb eax, xmm5
    popcnt eax, eax
    mov ecx, -1
    vptest xmm6, xmm1
    cmovnc eax, ecx 
    ret

%ifidn __OUTPUT_FORMAT__,elf64
section .note.GNU-stack noalloc noexec nowrite progbits
%endif
