section .rodata
   align 32
   nucleotides dq "A", "C", "G", "T"
   error dq -1, -1, -1, -1
  
section .text
global nucleotide_counts
nucleotide_counts:
    vpxor ymm0, ymm0
    vmovdqa ymm1, [rel nucleotides]
.loop:
    movzx eax, byte [rdi]
    test eax, eax
    jz .end
    vpbroadcastq ymm2, rax ; all 4 8-byte lanes of ymm1 now have the same value as rax
    vpcmpeqq ymm2, ymm2, ymm1 ; for each lane, if it is equal to the nucleotide in rax, all bits in the lane are set; bits are cleared otherwise
    vptest ymm2, ymm2 ; if all bits are cleared, nucleotide was not found, so it is invalid
    jz .error
    vpsubq ymm0, ymm2 ; all bits 1 means the lane has value -1. Subbing -1 is the same as adding 1. If all bits are cleared in the lane, sub doesn't change result
    inc rdi
    jmp .loop
.error:
    vmovdqa ymm0, [rel error] ; all lanes are now -1
.end:
    vmovdqu [rsi], ymm0 ; loads all 4 qwords at the same time
    ret

%ifidn __OUTPUT_FORMAT__,elf64
section .note.GNU-stack noalloc noexec nowrite progbits
%endif
