section .text

global to_rna
to_rna:
    xchg rsi, rdi
    mov rcx, 0x4300004147005500
.loop:
    movzx rdx, byte [rsi]
    inc rsi
    and rdx, 7
    shl rdx, 3
    shrx rax, rcx, rdx
    stosb
    test al, al
    jnz .loop
    ret
    
%ifidn __OUTPUT_FORMAT__,elf64
section .note.GNU-stack noalloc noexec nowrite progbits
%endif
