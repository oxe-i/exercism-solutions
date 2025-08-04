default rel

section .rodata
    grass db "grass"
    clover db "clover"
    radishes db "radishes"
    violets db "violets"

section .text
global plants

%macro add_separator 0
    mov al, ','
    stosb
    mov al, ' '
    stosb
%endmacro

add_grass:
    mov rcx, 5
    lea rsi, [grass]
    rep movsb
    add_separator
    jmp plant_added

add_clover:
    mov rcx, 6
    lea rsi, [clover]
    rep movsb
    add_separator
    jmp plant_added

add_radish:
    mov rcx, 8
    lea rsi, [radishes]
    rep movsb
    add_separator
    jmp plant_added

add_violet:
    mov rcx, 7
    lea rsi, [violets]
    rep movsb
    add_separator
    jmp plant_added

add_plant:
    xchg r11, rsi
    cld
    cmp al, 'G'
    je add_grass
    cmp al, 'C'
    je add_clover
    cmp al, 'R'
    je add_radish
    jmp add_violet
plant_added:
    xchg r11, rsi
    ret

plants:
    ; rdi - buffer (char array)
    ; rsi - diagram (string)
    ; rdx - student (string)
    ; return is void

    xor r10, r10
    mov r10b, byte [rdx]
    sub r10b, 'A'
    shl r10, 1 ; index corresponding to student in each row

    ; first row
    add rsi, r10
    lodsb
    call add_plant
    lodsb
    call add_plant

    dec rsi
find_end_of_row:
    lodsb
    cmp al, 10
    jne find_end_of_row

    ; second row
    lea rsi, [rsi + r10]
    lodsb
    call add_plant
    lodsb
    call add_plant

    sub rdi, 2 ; eliminate unnecessary separator
    mov al, 0
    stosb
    ret

%ifidn __OUTPUT_FORMAT__,elf64
section .note.GNU-stack noalloc noexec nowrite progbits
%endif
