default rel

section .rodata
    black db "black", 0
    brown db "brown", 0
    red db "red", 0
    orange db "orange", 0
    yellow db "yellow", 0
    green db "green", 0
    blue db "blue", 0
    violet db "violet", 0
    grey db "grey", 0
    white db "white", 0

section .bss
    all_colors resq 80
    is_filled resb 1
    
section .text

fill_colors:
    lea r8, [all_colors] ; colors array

    lea r9, [black]
    mov qword [r8], r9
    lea r9, [brown]
    mov qword [r8 + 8], r9
    lea r9, [red]
    mov qword [r8 + 16], r9
    lea r9, [orange]
    mov qword [r8 + 24], r9
    lea r9, [yellow]
    mov qword [r8 + 32], r9
    lea r9, [green]
    mov qword [r8 + 40], r9
    lea r9, [blue]
    mov qword [r8 + 48], r9
    lea r9, [violet]
    mov qword [r8 + 56], r9
    lea r9, [grey]
    mov qword [r8 + 64], r9
    lea r9, [white]
    mov qword [r8 + 72], r9

    ret

global color_code
color_code:
    ; rdi - input string
    ; output is an int in eax

    cmp byte [is_filled], 1
    je prepare_loop
    
    call fill_colors
    mov byte [is_filled], 1
prepare_loop:
    lea r8, [all_colors]
    mov rax, -1
loop_array:
    add rax, 1
    mov r9, qword [r8 + 8 * rax] ; crt string
    xor rcx, rcx
loop_string:
    mov r10b, byte [rdi + rcx] 
    cmp r10b, byte [r9 + rcx]
    jne loop_array
    cmp r10b, 0
    je end_color_code
    add rcx, 1
    jmp loop_string
end_color_code:
    ret

global colors
colors:
    ; no input
    ; output is a pointer in rax

    cmp byte [is_filled], 1
    je end_colors
    
    call fill_colors
    mov byte [is_filled], 1
    
end_colors:
    lea rax, [all_colors]
    ret

%ifidn __OUTPUT_FORMAT__,elf64
section .note.GNU-stack noalloc noexec nowrite progbits
%endif
