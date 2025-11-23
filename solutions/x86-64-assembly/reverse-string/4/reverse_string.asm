section .text
global reverse
reverse:
    mov rsi, rdi
    xor eax, eax
    mov rcx, -1
    repne scasb    
    times 2 dec rdi
.rev_loop:    
    lodsb
    xchg al, byte [rdi]
    mov byte [rsi - 1], al
    dec rdi
    cmp rdi, rsi
    jg .rev_loop  
    ret

%ifidn __OUTPUT_FORMAT__,elf64
section .note.GNU-stack noalloc noexec nowrite progbits
%endif
