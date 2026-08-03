section .text
global egg_count

; old-school SWAR implementation
egg_count:
    mov eax, edi
    and eax, 0x55555555
    shr edi, 1
    and edi, 0x55555555
    add eax, edi
    mov edi, eax
    and eax, 0x33333333
    shr edi, 2
    and edi, 0x33333333
    add eax, edi
    mov edi, eax
    shr edi, 4
    add eax, edi
    and eax, 0x0F0F0F0F
    imul eax, eax, 0x01010101
    shr eax, 24
    ret

; a more concise but branchy implementation using BMI1
egg_count2:
    mov eax, -1
.loop:
    inc eax
    blsr edi, edi ; requires BMI1
    jnc .loop
    ret

%ifidn __OUTPUT_FORMAT__,elf64
section .note.GNU-stack noalloc noexec nowrite progbits
%endif
