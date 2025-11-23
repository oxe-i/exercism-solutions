section .text
global reverse
reverse:
    mov rsi, rdi
    
    ; strlen
    xor eax, eax
    mov rcx, -1
    repne scasb
    not rcx

    shr rcx, 1           ; find mid
    lea rdx, [rcx - 1]   ; swap is symmetric
    cmovnc rcx, rdx      ; if size (including NUL) is even, there's an odd num of chars and mid is a single point
.rev_loop:
    test rdx, rdx
    js .end_rev
    
    mov al, byte [rsi + rdx]
    xchg al, byte [rsi + rcx]
    mov byte [rsi + rdx], al

    dec rdx
    inc rcx
    
    jmp .rev_loop
.end_rev:    
    ret

%ifidn __OUTPUT_FORMAT__,elf64
section .note.GNU-stack noalloc noexec nowrite progbits
%endif
