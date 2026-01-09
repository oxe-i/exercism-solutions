section .text
global find
find:
    xor r8d, r8d
    lea r9d, [esi - 1]
    mov esi, -1
.repeat:
    cmp r8d, r9d
    cmovg eax, esi
    jg .exit
    lea eax, [r8d + r9d]
    shr eax, 1
    lea r10d, [eax - 1]
    lea r11d, [eax + 1]
    mov ecx, dword [rdi + 4*rax]
    cmp ecx, edx
    cmovg r9d, r10d
    cmovl r8d, r11d
    jne .repeat
.exit:
    ret

%ifidn __OUTPUT_FORMAT__,elf64
section .note.GNU-stack noalloc noexec nowrite progbits
%endif
