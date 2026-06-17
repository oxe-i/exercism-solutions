section .rodata
align 16
nucleotides: db 0, "U", 0, "G", "A", 0, 0, "C", 0, 0, 0, 0, 0, 0, 0, 0
mod: times 16 db 15
tab: db 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15
     times 16 db 0x80

section .text
global to_rna
to_rna:
    movdqa xmm0, [rel nucleotides]
    movdqa xmm1, [rel mod]
    pxor xmm2, xmm2

    mov rax, rdi
    and rdi, -16
    and rax, 15
    mov rcx, 16
    sub rcx, rax
    
    lea rdx, [rel tab]
    movdqu xmm3, [rdx + rax]
    movdqa xmm4, [rdi]
    pshufb xmm4, xmm3
    
    movdqa xmm3, xmm4
    pcmpeqb xmm3, xmm2
    pmovmskb edx, xmm3
    bzhi edx, edx, ecx
    
    pand xmm4, xmm1
    movdqa xmm3, xmm0
    pshufb xmm3, xmm4
    movdqu [rsi], xmm3

    test edx, edx
    jnz .done
.loop:
    add rdi, 16
    movdqa xmm3, [rdi]
    
    movdqa xmm4, xmm3
    pcmpeqb xmm4, xmm2
    pmovmskb edx, xmm4
    
    pand xmm3, xmm1
    movdqa xmm4, xmm0
    pshufb xmm4, xmm3
    movdqu [rsi + rcx], xmm4    
    add rcx, 16
    
    test edx, edx
    jz .loop
.done:
    ret

%ifidn __OUTPUT_FORMAT__,elf64
section .note.GNU-stack noalloc noexec nowrite progbits
%endif
