section .text
global factors
factors:
    mov r11, rdi
    
    tzcnt rcx, rsi
    shr rsi, cl
    mov rax, 2
    rep stosq

    mov ecx, 1
    mov r8d, 1
.odd:
    cmp rsi, 1
    je .done
    
    mov r10, r8
    lea r8, [r8 + 4*rcx + 4]
    
    cmp r8, rsi
    ja .prime
    
    add ecx, 2
    mov rax, rsi
    xor edx, edx
    div rcx
    test rdx, rdx
    jnz .odd

    mov qword [rdi], rcx
    add rdi, 8

    mov rsi, rax
    sub rcx, 2
    mov r8, r10
    jmp .odd
.prime:
    mov qword [rdi], rsi
    add rdi, 8
.done:
    mov rax, rdi
    sub rax, r11
    shr rax, 3
    ret

%ifidn __OUTPUT_FORMAT__,elf64
section .note.GNU-stack noalloc noexec nowrite progbits
%endif
