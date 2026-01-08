section .data
    crs dq "black", "brown", "red", "orange", "yellow", "green", "blue", "violet", "grey", "white"
    color_array dq crs, crs + 8, crs + 16, crs + 24, crs + 32, crs + 40, crs + 48, crs + 56, crs + 64, crs + 72

section .text
global color_code
color_code:
    lea rdx, [rel crs]
    mov cx, word [rdi]
    mov eax, -1
.find_pos:
    inc eax
    cmp cx, word [rdx + 8*rax]
    jnz .find_pos
    ret

global colors
colors:
    lea rax, [rel color_array]
    ret

%ifidn __OUTPUT_FORMAT__,elf64
section .note.GNU-stack noalloc noexec nowrite progbits
%endif
