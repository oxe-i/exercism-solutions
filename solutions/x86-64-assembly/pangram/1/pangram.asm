section .text

is_upper:
    xor rax, rax
    cmp r9b, 'A'
    jl upper_end
    cmp r9b, 'Z'
    jg upper_end
    mov rax, 1
upper_end:
    ret

is_lower:
    xor rax, rax
    cmp r9b, 'a'
    jl lower_end
    cmp r9b, 'z'
    jg lower_end
    mov rax, 1
lower_end:
    ret

global is_pangram
is_pangram:
    push rbp
    mov rbp, rsp
    sub rsp, 26
    
    lea r8, [rbp - 26]
    mov rcx, 26
fill_stack_array:
    mov byte [r8 + rcx - 1], 0
    loop fill_stack_array
    
    xor rax, rax
    xor r9, r9
    xor rcx, rcx
loop:
    mov r9b, byte [rdi + rcx]
    add rcx, 1
    
    cmp r9b, 0
    je check_filled_loop

    call is_upper
    
    cmp rax, 1
    jne check_lower
    
    sub r9b, 'A'
    mov byte [r8 + r9], 1
    jmp loop    
check_lower:
    call is_lower

    cmp rax, 1
    jne loop

    sub r9b, 'a'
    mov byte [r8 + r9], 1
    jmp loop    
check_filled_loop:
    xor rax, rax
    mov rcx, 26
check_array:
    cmp byte [r8 + rcx - 1], 1
    jne end
    loop check_array
    mov rax, 1
end:
    mov rsp, rbp
    pop rbp
    ret

%ifidn __OUTPUT_FORMAT__,elf64
section .note.GNU-stack noalloc noexec nowrite progbits
%endif
