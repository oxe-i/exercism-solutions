section .text
global distance
distance:
    xor rcx, rcx
    xor rax, rax
loop:
    mov r8b, byte [rdi + rcx]
    mov r9b, byte [rsi + rcx]
    add rcx, 1
    cmp r8b, 0
    je check
    cmp r9b, 0
    je error
    cmp r8b, r9b
    je loop
    add rax, 1
    jmp loop
check:
    cmp r9b, 0
    je end
error:
    mov rax, -1
end:
    ret

%ifidn __OUTPUT_FORMAT__,elf64
section .note.GNU-stack noalloc noexec nowrite progbits
%endif
