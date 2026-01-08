section .text
global reverse
reverse:
    mov rsi, rdi
    xor eax, eax
    mov rcx, -1
    repne scasb  
    sub rdi, 2
.rev_loop:    
    mov al, byte [rsi]
    mov dl, byte [rdi]
    mov byte [rdi], al
    mov byte [rsi], dl
    dec rdi
    inc rsi
    cmp rdi, rsi
    ja .rev_loop  
    ret

%ifidn __OUTPUT_FORMAT__,elf64
section .note.GNU-stack noalloc noexec nowrite progbits
%endif