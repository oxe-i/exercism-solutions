default rel

section .rodata
    black db 6, "black", 0, 0
    brown db 6, "brown", 0, 1
    red db 4, "red", 0, 2
    orange db 7, "orange", 0, 3
    yellow db 7, "yellow", 0, 4
    green db 6, "green", 0, 5
    blue db 5, "blue", 0, 6
    violet db 7, "violet", 0, 7
    grey db 5, "grey", 0, 8
    white db 6, "white", 0, 9

section .text

%macro find_color 1
    lea r11, [black]
    xor rax, rax
    cld
%%loop:
    mov rdi, %1
    mov rsi, r11
    lodsb
    mov rcx, rax
    add r11, rax
    add r11, 2
    rep cmpsb
    jne %%loop
%%end:
    lodsb
%endmacro
    
global value
value:
    ; rdi - first color string
    ; rsi - second color string
    ; output in eax

    mov r8, rdi
    mov r9, rsi
    xor r10, r10
    find_color r8
    imul r10, rax, 10
    find_color r9
    add rax, r10
    ret

%ifidn __OUTPUT_FORMAT__,elf64
section .note.GNU-stack noalloc noexec nowrite progbits
%endif
