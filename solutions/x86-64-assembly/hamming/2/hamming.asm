section .text
global distance
distance:
    ; following code is correct for strings up to 16 bytes in size
    ; otherwise a loop would be needed
    
    vmovdqu xmm1, [rsi]
    vmovdqu xmm2, [rdi]
    
    vpxor xmm3, xmm3
    vpcmpistri xmm3, xmm2, 0b00_00_10_00 ; compare for equality byte-wise
    ; ecx holds the index of first equal element. Since xmm3 is empty, it is NUL's index
    mov edx, ecx
    vpcmpistri xmm3, xmm1, 0b00_00_10_00
    ; now if ecx and edx are different, strings have different lengths
    
    vpcmpistrm xmm1, xmm2, 0b00_01_10_00 ; compare for not equality byte-wise
    ; stores the result as a mask in xmm0
    vmovq rax, xmm0
    popcnt rax, rax ; number of different bytes

    mov edi, -1
    cmp ecx, edx
    cmovnz eax, edi ; different lengths signals error
    ret

%ifidn __OUTPUT_FORMAT__,elf64
section .note.GNU-stack noalloc noexec nowrite progbits
%endif
