section .text
global score

    outer_r dq 100.0
    mid_r   dq  25.0
    inner_r dq   1.0
    
score:
    xor eax, eax
    
    mulsd xmm0, xmm0
    mulsd xmm1, xmm1
    addsd xmm0, xmm1    

    lea edx, [eax + 5]
    ucomisd xmm0, qword [rel inner_r]
    cmovbe eax, edx

    lea edx, [eax + 4]
    ucomisd xmm0, qword [rel mid_r]
    cmovbe eax, edx

    lea edx, [eax + 1]
    ucomisd xmm0, qword [rel outer_r]
    cmovbe eax, edx
    
    ret

%ifidn __OUTPUT_FORMAT__,elf64
section .note.GNU-stack noalloc noexec nowrite progbits
%endif
