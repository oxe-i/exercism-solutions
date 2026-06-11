section .text
global transform
transform:
    ; Provide your implementation here
    xor eax, eax
    shl rdx, 5
    jz .exit

    sub rsp, 26 * 8
    xor ecx, ecx
    lea rdx, [rsi + rdx]
align 32
.loop:
    mov r8d, [rsi]
    shl r8, 32
    movzx r9d, byte [rsi + 4]
align 32
.inner:
    movzx r11d, byte [rsi + 4 + r9]
    lea r10, [r11 + r8 + 32]
    sub r11d, 'A'
    bts ecx, r11d
    mov [rsp + 8*r11], r10
    dec r9
    jnz .inner

    add rsi, 32
    cmp rsi, rdx
    jb .loop
    
align 32   
.store:
    tzcnt r8d, ecx
    mov r8, [rsp + 8*r8]
    mov [rdi + 8*rax], r8
    inc rax
    blsr ecx, ecx
    jnz .store

    add rsp, 26 * 8
.exit:
    ret

%ifidn __OUTPUT_FORMAT__,elf64
section .note.GNU-stack noalloc noexec nowrite progbits
%endif
