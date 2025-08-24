section .text
global steps
steps:
    ; edi - initial number, as a 32-bit integer
    ; return is a 32-bit integer in eax

    xor rax, rax
.steps_loop:
    cmp edi, 1
    jl .invalid
    je .return

    inc rax
    bt edi, 0
    jc .handle_odd

    shr edi, 1
    jmp .steps_loop

.handle_odd:
    imul edi, edi, 3
    inc edi
    jmp .steps_loop
    
.invalid:
    mov rax, -1
.return:
    ret

%ifidn __OUTPUT_FORMAT__,elf64
section .note.GNU-stack noalloc noexec nowrite progbits
%endif
