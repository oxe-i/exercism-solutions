section .rodata
   nucleotides  dq "A", "C", "G", "T"
   error dq -1
  
section .text
global nucleotide_counts
nucleotide_counts:
    vpxor ymm0, ymm0
.loop:
    movzx rax, byte [rdi]
    test rax, rax
    jz .end
    vpbroadcastq ymm1, rax
    vpcmpeqq ymm1, ymm1, [rel nucleotides]
    vptest ymm1, ymm1
    jz .error
    vpsubq ymm0, ymm1
    inc rdi
    jmp .loop
.error:
    vpbroadcastq ymm0, [rel error]
.end:
    vmovups [rsi], ymm0
    ret

%ifidn __OUTPUT_FORMAT__,elf64
section .note.GNU-stack noalloc noexec nowrite progbits
%endif
