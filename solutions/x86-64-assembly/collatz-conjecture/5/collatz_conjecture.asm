ERROR_VALUE equ -1

section .text
global steps
steps:
    mov eax, ERROR_VALUE
.repeat:
    rol edi, 1         ; adds 1 trailing zero, for previous odd number or clearing error
    tzcnt edx, edi
    and edx, 31        ; 32 trailing zeros -> number is 0
    add eax, edx       ; adds 0 for num <= 0, otherwise counts even sequence + 1 for rol
    shrx edi, edi, edx ; gets to first odd num in sequence
    lea edi, [edi + 2*edi + 1]  ; x = 3x + 1
                                ; step for odd number will be counted on next iteration
    cmp edi, 4
    jg .repeat         ; x == 4 -> it was 1 before. 
                       ; x < 4  -> it was negative or 0 before
    ret

%ifidn __OUTPUT_FORMAT__,elf64
section .note.GNU-stack noalloc noexec nowrite progbits
%endif