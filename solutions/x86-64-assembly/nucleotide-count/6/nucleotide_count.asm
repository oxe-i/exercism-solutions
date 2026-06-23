section .rodata
nucleotides: dq "A", "C", "G", "T"
     
section .text
global nucleotide_counts
nucleotide_counts:
    vpxor ymm0, ymm0, ymm0
    vmovdqu ymm1, [rel nucleotides]
.loop:
    movzx eax, byte [rdi]
    inc rdi
    test eax, eax
    jz .end
    vpbroadcastq ymm3, rax 
    vpcmpeqq ymm3, ymm3, ymm1
    vpsubq ymm0, ymm3
    vptest ymm3, ymm3
    jnz .loop
    vpcmpeqq ymm0, ymm0, ymm0
.end:
    vmovdqu [rsi], ymm0
    ret

%ifidn __OUTPUT_FORMAT__,elf64
section .note.GNU-stack noalloc noexec nowrite progbits
%endif
