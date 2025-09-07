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

    mov esi, edi
    shr esi, 1

    mov ecx, edi
    times 2 add ecx, edi
    inc ecx
    
    bt edi, 0
    cmovc edi, ecx
    cmovnc edi, esi
    
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
