section .text
global largest
global smallest

largest:
    xor r11d, r11d
    
    cmp rsi, rdx
    ja .invalid
    
    push rbx
    push r12
    push r13
    
    mov r12, rdx
    mov rbx, rdi
    add rdi, 8
    mov r10, 10
.outer:
    cmp rsi, r12
    ja .end_outer
    
    mov r8, rsi
.inner:
    cmp r8, r12
    ja .end_inner

    mov r9, r8
    imul r9, rsi 
    mov rcx, r9
    xor r13d, r13d
.extract_digits:
    test r9, r9
    jz .end_extract
    
    mov rax, (-1 / 10) + 1    
    mul r9
    mov r9, rdx
    mul r10   

    imul rax, r13, 10
    lea r13, [rax + rdx]
    
    jmp .extract_digits    
.end_extract:
    cmp r13, rcx
    jnz .prepare_inner

    cmp r11, rcx
    je .add
    ja .prepare_inner

    mov qword [rbx], 0
    lea rdi, [rbx + 8]
    mov r11, rcx
.add:
    inc qword [rbx]
    mov qword [rdi], rsi
    mov qword [rdi + 8], r8
    add rdi, 16
    
.prepare_inner:
    inc r8
    jmp .inner
    
.end_inner:
    inc rsi
    jmp .outer
    
.end_outer:
    pop r13
    pop r12
    pop rbx
    
    mov rax, r11
    ret
.invalid:
    dec r11
    mov rax, r11
    ret

smallest:
    mov r11, -1
    
    cmp rsi, rdx
    ja .invalid
    
    push rbx
    push r12
    push r13
    
    mov r12, rdx
    mov rbx, rdi
    add rdi, 8
    mov r10, 10
.outer:
    cmp rsi, r12
    ja .end_outer
    
    mov r8, rsi
.inner:
    cmp r8, r12
    ja .end_inner

    mov r9, r8
    imul r9, rsi 
    mov rcx, r9
    xor r13d, r13d
.extract_digits:
    test r9, r9
    jz .end_extract
    
    mov rax, (-1 / 10) + 1    
    mul r9
    mov r9, rdx
    mul r10   

    imul rax, r13, 10
    lea r13, [rax + rdx]
    
    jmp .extract_digits    
.end_extract:
    cmp r13, rcx
    jnz .prepare_inner

    cmp r11, rcx
    je .add
    jb .prepare_inner

    mov qword [rbx], 0
    lea rdi, [rbx + 8]
    mov r11, rcx
.add:
    inc qword [rbx]
    mov qword [rdi], rsi
    mov qword [rdi + 8], r8
    add rdi, 16
    
.prepare_inner:
    inc r8
    jmp .inner
    
.end_inner:
    inc rsi
    jmp .outer
    
.end_outer:
    pop r13
    pop r12
    pop rbx

    xor eax, eax
    cmp r11, -1
    cmovne rax, r11
    ret
.invalid:
    mov rax, r11
    ret

%ifidn __OUTPUT_FORMAT__,elf64
section .note.GNU-stack noalloc noexec nowrite progbits
%endif
