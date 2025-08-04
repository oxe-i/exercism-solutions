default rel

section .bss
    digits resb 100

section .text
global valid
valid:
    ; rdi - input string
    ; output is a boolean in eax
    
    mov rsi, rdi
    lea rdi, [digits]
    xor rcx, rcx ; counter
    mov r10, 10 ; for division
    xor r8, r8 ; flag for digit to double
    xor r9, r9 ; accumulator
    cld
count:
    lodsb
    cmp al, 0
    je end_count
    cmp al, ' '
    je count
    cmp al, '0'
    jl false
    cmp al, '9'
    jg false
    inc rcx
    stosb
    jmp count
end_count:
    cmp rcx, 1
    jle false
    
    lea rsi, [rdi - 1]    
    xor rax, rax
    std
accumulate:
    lodsb
    sub al, '0'
    xor r11, r11
    btc r8, 0
    cmovc r11, rax
    add rax, r11
    xor rdx, rdx
    div r10
    add r9, rax
    add r9, rdx
    loop accumulate
    
    mov rax, r9
    xor rdx, rdx
    div r10
    cmp rdx, 0
    jne false
true:
    mov rax, 1
    ret
false:
    xor rax, rax
    ret

%ifidn __OUTPUT_FORMAT__,elf64
section .note.GNU-stack noalloc noexec nowrite progbits
%endif
