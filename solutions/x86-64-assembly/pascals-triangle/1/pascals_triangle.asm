section .text
global rows
rows:
    ; rdi - output array of uint64_t
    ; rsi - count (size_t)
    ; output array should me modified in place
    ; return is size of array

    xor rax, rax
    cmp rsi, 2
    jle base_case

    dec rsi
    call rows

    mov r10, rdi
    mov r11, rsi
    shl r11, 3
    sub r10, r11

    mov qword [rdi], 1
    add rdi, 8
    mov rcx, rsi
    dec rcx
sum_nums:
    mov r8, qword [r10]
    mov r9, qword [r10 + 8]
    add r10, 8
    add r8, r9
    mov qword [rdi], r8
    add rdi, 8
    loop sum_nums

    mov qword [rdi], 1
    add rdi, 8
    inc rsi
    add rax, rsi
    jmp end
base_case:
    cmp rsi, 0
    je end
    
    mov qword [rdi], 1
    add rdi, 8
    inc rax

    cmp rsi, 1
    je end

    mov qword [rdi], 1
    add rdi, 8

    mov qword [rdi], 1
    add rdi, 8
    add rax, rsi
end:    
    ret

%ifidn __OUTPUT_FORMAT__,elf64
section .note.GNU-stack noalloc noexec nowrite progbits
%endif
