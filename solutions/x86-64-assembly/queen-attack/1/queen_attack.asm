section .text

%macro ABS 1
    cmp %1, 0
    jge %%end
    neg %1
%%end:
%endmacro

global can_create

true:
    mov eax, 1
    ret

false:
    mov eax, 0
    ret

can_create:
    ; edi - row
    ; esi - col
    ; returns boolean in eax
    
    xor r8d, r8d
    bts r8d, 3
    sub r8d, 1
    neg r8d ; bit mask with all bits after the fourth set
    
    and edi, r8d ; zeroes bits up to the fourth (value 8)
    and esi, r8d ; zeroes bits up to the fourth (value 8)
    
    test edi, edi
    jnz false ; any bit set beyond the eighth is invalid
    
    test esi, esi
    jnz false ; any bit set beyond the eighth is invalid
    
    jmp true

global can_attack
can_attack:
    ; edi - row1
    ; esi - col1
    ; edx - row2
    ; ecx - col2
    ; returns boolean in eax

    cmp edi, edx
    je true
    
    cmp esi, ecx
    je true

    sub edi, edx
    ABS edi

    sub esi, ecx
    ABS esi

    cmp edi, esi
    je true
    
    jmp false

%ifidn __OUTPUT_FORMAT__,elf64
section .note.GNU-stack noalloc noexec nowrite progbits
%endif
