section .text
global steps
steps:
    ; edi - initial number, as a 32-bit integer
    ; return is a 32-bit integer in eax

    mov rax, -1
    cmp edi, 1
    jl .return
    inc rax
.loop:
    cmp edi, 1
    je .return

    inc rax
    lea r8d, [2*edi + edi + 1]
    mov r9d, edi
    shr r9d, 1
    bt edi, 0
    cmovc edi, r8d
    cmovnc edi, r9d
    jmp .loop
.return:
    ret

%ifidn __OUTPUT_FORMAT__,elf64
section .note.GNU-stack noalloc noexec nowrite progbits
%endif
