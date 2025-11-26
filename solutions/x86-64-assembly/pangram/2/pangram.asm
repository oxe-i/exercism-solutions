section .text
global is_pangram
is_pangram:
    mov eax, 31
    xor edx, edx         ; bitmap
.check:
    movzx esi, byte [rdi]
    test esi, esi
    jz .end_check        ; found NUL
    inc rdi 
    or esi, 32           ; to lower
    sub esi, 97          ; normalize to range [0, 26)
    cmp esi, 26
    cmovae esi, eax      ; not a letter
    bts edx, esi         ; set bit in bitmap
    jmp .check
.end_check:
    and edx, 0x03FFFFFF  ; bits from idx 0 to idx 25
    cmp edx, 0x03FFFFFF  
    setz al              ; all bits are set if equal
    ret

%ifidn __OUTPUT_FORMAT__,elf64
section .note.GNU-stack noalloc noexec nowrite progbits
%endif
