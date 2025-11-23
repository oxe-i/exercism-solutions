section .text
global find
find:
    sub esi, 1   ; high
    xor ecx, ecx ; low
.loop:
    cmp ecx, esi
    jg .error
    lea eax, [esi + ecx]
    shr eax, 1   ; mid
    lea r8d, [eax - 1]
    lea r9d, [eax + 1]
    cmp edx, dword [rdi + 4 * rax]
    cmovl esi, r8d
    cmovg ecx, r9d
    jne .loop
    ret

.error:
    mov eax, -1
    ret

%ifidn __OUTPUT_FORMAT__,elf64
section .note.GNU-stack noalloc noexec nowrite progbits
%endif
