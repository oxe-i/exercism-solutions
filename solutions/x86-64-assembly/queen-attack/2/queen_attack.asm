section .text

global can_create
can_create:
    ; edi - row
    ; esi - col
    ; returns boolean in eax
    
    xor eax, eax
    cmp edi, 8
    setnae al
    cmp esi, 8
    setnae dl
    and al, dl
    ret

global can_attack
can_attack:
    ; edi - row1
    ; esi - col1
    ; edx - row2
    ; ecx - col2
    ; returns boolean in eax
    
    xor eax, eax
    mov r8d, 1
    
    mov r9d, edi    
    cmp edi, edx
    cmove eax, r8d
    cmovb edi, edx
    cmovb edx, r9d

    mov r9d, esi
    cmp esi, ecx
    cmove eax, r8d
    cmovb esi, ecx
    cmovb ecx, r9d

    sub edi, edx
    sub esi, ecx
    cmp edi, esi
    cmove eax, r8d
    ret

%ifidn __OUTPUT_FORMAT__,elf64
section .note.GNU-stack noalloc noexec nowrite progbits
%endif
