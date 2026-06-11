section .text
global is_isogram
is_isogram:
    mov eax, 1
    xor edx, edx
align 32
.loop:
    movzx esi, byte [rdi]
    inc rdi
    test esi, esi
    jz .exit
    and esi, ~32
    sub esi, 'A'
    cmp esi, 26
    jae .loop
    bts edx, esi
    jnc .loop
    xor eax, eax
.exit:
    ret

%ifidn __OUTPUT_FORMAT__,elf64
section .note.GNU-stack noalloc noexec nowrite progbits
%endif
