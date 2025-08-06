section .text

is_upper:
    cmp al, 'A'
    jl false
    cmp al, 'Z'
    jg false
    jmp true

is_lower:
    cmp al, 'a'
    jl false
    cmp al, 'z'
    jg false
    jmp true

false:
    xor r10, r10
    ret

true:
    mov r10, 1
    ret

global rotate
rotate:
    ; rdi - text
    ; esi - shift
    ; rdx - buffer
    ; return is void

    xor r11, r11
    mov r11d, esi
    mov rsi, rdi
    mov rdi, rdx
loop:
    lodsb
    call is_lower
    cmp r10, 1
    je handle_lower
    call is_upper
    cmp r10, 1
    je handle_upper
    stosb
    cmp al, 0
    jne loop
    jmp end

handle_lower:
    sub al, 'a'
    add rax, r11
    mov r9, 26
    xor rdx, rdx
    div r9
    xchg rdx, rax
    add al, 'a'
    stosb
    jmp loop

handle_upper:
    sub al, 'A'
    add rax, r11
    mov r9, 26
    xor rdx, rdx
    div r9
    xchg rdx, rax
    add al, 'A'
    stosb
    jmp loop
end: 
    ret

%ifidn __OUTPUT_FORMAT__,elf64
section .note.GNU-stack noalloc noexec nowrite progbits
%endif
