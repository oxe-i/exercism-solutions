section .text
global square_root
square_root:
    mov eax, 0x3F000000
    vmovd xmm2, eax
    vcvtsi2ss xmm0, edi
    vmulss xmm1, xmm0, xmm2 ; half
.babylonian_method:
    vdivss xmm3, xmm0, xmm1
    vaddss xmm1, xmm3
    vmulss xmm1, xmm2
    vmulss xmm3, xmm1, xmm1
    vcomiss xmm0, xmm3
    jne .babylonian_method
    vcvtss2si eax, xmm1
    ret

%ifidn __OUTPUT_FORMAT__,elf64
section .note.GNU-stack noalloc noexec nowrite progbits
%endif