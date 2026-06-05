section .text
global rows
rows:
    lea rax, [rsi + 1]
    imul rax, rsi
    shr rax, 1
    
    mov qword [rdi], 1

    lea rsi, [rdi + 8*rax]
    lea rcx, [rdi + 8]
    lea rdx, [rdi]
.loop:
    mov r8, rcx
    xor r9d, r9d
    xor r10d, r10d
.row:
    mov r10, r9
    mov r9, [rdx]
    add rdx, 8

    lea r11, [r9 + r10]
    mov [rcx], r11
    add rcx, 8
    
    cmp rdx, r8
    jb .row

    mov qword [rcx], 1
    add rcx, 8
    cmp rcx, rsi
    jb .loop
 
    ret

%ifidn __OUTPUT_FORMAT__,elf64
section .note.GNU-stack noalloc noexec nowrite progbits
%endif
