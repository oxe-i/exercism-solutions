section .text

%macro STRCAT 1
    mov byte [rsi + rcx], %1
    add rcx, 1
%endmacro

%macro CMP_CAT 2
    cmp byte [rdi + rcx], %1
    je %2
%endmacro

global to_rna
to_rna:
    xor rcx, rcx
    call loop
    ret

loop:
    CMP_CAT 0, end_loop
    CMP_CAT 'C', add_G
    CMP_CAT 'G', add_C
    CMP_CAT 'A', add_U
    jmp add_A

add_G:
    STRCAT 'G'
    jmp loop

add_C:
    STRCAT 'C'
    jmp loop

add_U:
    STRCAT 'U'
    jmp loop

add_A:
    STRCAT 'A'
    jmp loop

end_loop:
    STRCAT 0
    ret
    

%ifidn __OUTPUT_FORMAT__,elf64
section .note.GNU-stack noalloc noexec nowrite progbits
%endif
