section .text

global can_create
can_create:
    ; edi - row
    ; esi - col
    ; returns boolean in eax

    mov eax, 7
    or edi, esi
    andn edi, eax, edi
    setz al
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
    
    sub edi, edx
    cmovz eax, r8d
    
    sub esi, ecx
    cmovz eax, r8d
  
    mov edx, edi
    sub edx, esi
    cmovz eax, r8d
    
    add edi, esi
    cmovz eax, r8d
    ret

%ifidn __OUTPUT_FORMAT__,elf64
section .note.GNU-stack noalloc noexec nowrite progbits
%endif
