default rel

section .rodata
    pling db "Pling"
    plang db "Plang"
    plong db "Plong"

section .bss
    digits resb 10

section .text

%macro is_divisible_by 2
    mov rax, %1
    xor rdx, rdx
    mov rcx, %2
    div rcx
    cmp rdx, 0
%endmacro

%macro add_string 1
    lea rsi, [%1]
    mov rcx, 5
    rep movsb
%endmacro

global convert
convert:
    ; edi - number to convert
    ; rsi - output string
    ; output should be modified in place
    ; return is void

    mov r11, rsi
    xor r10, r10
    mov r10d, edi
    mov rdi, rsi
    xor r8, r8
    cld
check_pling:
    is_divisible_by r10, 3
    jne check_plang
    mov r8, 1
    add_string pling
check_plang:
    is_divisible_by r10, 5
    jne check_plong
    mov r8, 1
    add_string plang
check_plong:
    is_divisible_by r10, 7
    jne check_stringify
    mov r8, 1
    add_string plong
check_stringify:
    mov rsi, rdi
    cmp r8, 0
    jne end
stringify_num:
    lea rdi, [digits]
    mov rax, r10
    mov r9, 10
    xor rcx, rcx
    cld
get_digits:
    inc rcx
    xor rdx, rdx
    div r9
    xchg rdx, rax
    add al, '0'
    stosb
    sub al, '0'
    xchg rdx, rax
    cmp rax, 0
    jne get_digits
insert_digits:
    sub rdi, 1
    xchg rdi, rsi
insert_loop:
    mov al, byte [rsi]
    dec rsi
    stosb
    loop insert_loop
end: 
    mov al, 0
    stosb
    ret

%ifidn __OUTPUT_FORMAT__,elf64
section .note.GNU-stack noalloc noexec nowrite progbits
%endif
