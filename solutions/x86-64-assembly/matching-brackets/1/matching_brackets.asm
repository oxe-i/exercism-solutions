section .text
global is_paired
is_paired:
    mov rsi, rdi
    mov rdi, rsp
    mov rcx, rsp
    sub rsp, 1000
    mov r8, ']'
    mov r9, '}'
    mov r10, ')'
.loop:
    lodsb
    
    test al, al
    jz .exit

    cmp al, '['
    cmove eax, r8d
    je .store

    cmp al, '{'
    cmove eax, r9d
    je .store

    cmp al, '('
    cmove eax, r10d
    je .store

    cmp al, ']'
    je .compare

    cmp al, '}'
    je .compare

    cmp al, ')'
    je .compare

    jmp .loop

.store:
    dec rdi
    mov byte [rdi], al
    lea rdx, [rsp - 1000]
    cmp rdi, rsp
    cmove rsp, rdx
    jmp .loop

.compare:
    cmp rdi, rcx
    je .false

    scasb
    je .loop
    
.false:
    mov rsp, rcx
    mov eax, 0
    ret
    
.exit:
    mov rsp, rcx
    cmp rdi, rcx
    sete al
    movzx eax, al
    ret

%ifidn __OUTPUT_FORMAT__,elf64
section .note.GNU-stack noalloc noexec nowrite progbits
%endif
