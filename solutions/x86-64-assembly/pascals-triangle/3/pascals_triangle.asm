section .text
global rows
rows:
    lea rax, [rsi + 1]
    imul rax, rsi
    shr rax, 1
    
    mov qword [rdi], 1
    mov rcx, 1
.loop:
    lea r8, [rdi + 8*rcx]
    xor r9d, r9d
.row:
    mov r10, r9
    mov r9, [rdi]

    lea r11, [r9 + r10]
    mov [rdi + 8*rcx], r11
    
    add rdi, 8
    cmp rdi, r8
    jb .row

    mov qword [rdi + 8*rcx], 1
    inc rcx
    cmp rcx, rsi
    jb .loop
 
    ret

%ifidn __OUTPUT_FORMAT__,elf64
section .note.GNU-stack noalloc noexec nowrite progbits
%endif
