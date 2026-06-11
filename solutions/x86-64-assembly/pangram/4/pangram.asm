section .text
global is_pangram
is_pangram:
    xor edx, edx
    xor eax, eax
align 32
.loop:
    movzx esi, byte [rdi]
    test esi, esi
    jz .exit
    inc rdi
    and esi, ~32
    sub esi, 'A'
    cmp esi, 26
    jae .loop
    bts edx, esi
    cmp edx, (1 << 26) - 1
    jnz .loop
    setz al
.exit:
    ret

%ifidn __OUTPUT_FORMAT__,elf64
section .note.GNU-stack noalloc noexec nowrite progbits
%endif
