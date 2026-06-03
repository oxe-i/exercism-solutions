section .text

global can_create
can_create:
    ; edi - row
    ; esi - col
    ; returns boolean in eax

    or edi, esi
    cmp edi, 8
    setb al
    movzx eax, al
    ret

global can_attack
can_attack:
    ; edi - row1
    ; esi - col1
    ; edx - row2
    ; ecx - col2
    ; returns boolean in eax

    sub edi, edx
    setz r8b

    sub esi, ecx
    setz r9b

    mov edx, edi
    sub edx, esi
    setz r10b

    add edi, esi
    setz al

    or al, r8b
    or al, r9b
    or al, r10b

    movzx eax, al
    ret

%ifidn __OUTPUT_FORMAT__,elf64
section .note.GNU-stack noalloc noexec nowrite progbits
%endif
