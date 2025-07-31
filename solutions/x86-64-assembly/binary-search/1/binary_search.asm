section .text
global find
find:
    xor rax, rax
    sub esi, 1 ; high
    mov ecx, 0 ; low
loop:
    cmp ecx, esi
    jg error
    mov eax, esi
    add eax, ecx
    shr eax, 1 ; mid
    cmp edx, dword [rdi + 4 * rax]
    jl set_high
    jg set_low
    ret

error:
    mov eax, -1
    ret

set_high:
    mov esi, eax
    sub esi, 1
    jmp loop

set_low:
    mov ecx, eax
    add ecx, 1
    jmp loop


%ifidn __OUTPUT_FORMAT__,elf64
section .note.GNU-stack noalloc noexec nowrite progbits
%endif
