section .rodata
    seconds_in_year: dd 31557600.0
    planets: dd 0.2408467, 0.61519726, 1.0, 1.8808158, 11.862615, 29.447498, 84.016846, 164.79132 

section .text
global age
age:     
    lea r8, [rel planets]
    mov ecx, edi
    
    cvtsi2ss xmm0, esi
    divss xmm0, dword [rel seconds_in_year]
    divss xmm0, dword [r8 + 4 * rcx]    

    ret

%ifidn __OUTPUT_FORMAT__,elf64
section .note.GNU-stack noalloc noexec nowrite progbits
%endif
