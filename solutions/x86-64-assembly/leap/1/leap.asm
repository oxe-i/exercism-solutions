section .text

%macro CHECK_AND_CMP 1
    mov eax, edi
    xor edx, edx
    mov ecx, %1
    div ecx
    cmp edx, 0
%endmacro

global leap_year
leap_year:
    CHECK_AND_CMP 400
    je return_true
    CHECK_AND_CMP 100
    je return_false
    CHECK_AND_CMP 4
    je return_true
    jmp return_false
    
return_true:
    mov eax, 1
    ret

return_false:
    mov eax, 0
    ret

%ifidn __OUTPUT_FORMAT__,elf64
section .note.GNU-stack noalloc noexec nowrite progbits
%endif
