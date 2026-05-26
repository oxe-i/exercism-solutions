section .text
seconds_in_year: dd 0.0000000316880878
planets: dd 4.1520186907, 1.625494886, 1.0, 0.5316841766, 0.0842984452, 0.0339587424, 0.0119023749, 0.0060682808

global age
age:     
    lea r8, [rel planets]
    mov edi, edi
    
    vcvtsi2ss xmm0, xmm0, esi
    vmulss xmm0, xmm0, [rel seconds_in_year]
    vmulss xmm0, xmm0, [r8 + 4 * rdi]

    ret

%ifidn __OUTPUT_FORMAT__,elf64
section .note.GNU-stack noalloc noexec nowrite progbits
%endif
