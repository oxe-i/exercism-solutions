default rel

section .rodata
   want db "For want of a "
   want_len equ $ - want

   the db " the "
   the_len equ $ - the

   lost db " was lost.", `\n`
   lost_len equ $ - lost
   
   last db "And all for the want of a "
   last_len equ $ - last

section .text
global recite
recite:
    push r12
    
    mov rdx, qword [rsi]
    test rdx, rdx
    jz .exit
   
    mov r12, rsi
    mov r11, rdx
    
    mov r10d, -32
    pxor xmm0, xmm0
.get_len:
    add r10d, 32
    pcmpistri xmm0, [rdx + r10], 0b10_00
    jnz .get_len
    
    add r10d, ecx
    mov r9d, r10d
.repeat:
    mov r8, qword [r12 + 8]
    test r8, r8
    jz .epilogue
    add r12, 8

    lea rsi, [want]
    mov rcx, want_len
    rep movsb

    mov rsi, rdx
    mov ecx, r9d
    rep movsb

    lea rsi, [the]
    mov ecx, the_len
    rep movsb

    mov r9d, -1
.add_second:
    inc r9d
    mov al, byte [r8 + r9]
    stosb
    test al, al
    jnz .add_second

    dec rdi
    lea rsi, [lost]
    mov ecx, lost_len
    rep movsb

    mov rdx, r8
    jmp .repeat

.epilogue:
    lea rsi, [last]
    mov ecx, last_len
    rep movsb

    mov rsi, r11
    mov ecx, r10d
    rep movsb

    mov ax, `.\n`
    stosw
.exit:
    mov byte [rdi], 0
    pop r12
    ret

%ifidn __OUTPUT_FORMAT__,elf64
section .note.GNU-stack noalloc noexec nowrite progbits
%endif
