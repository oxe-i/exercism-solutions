section .text

is_digit:
    cmp r10b, '0'
    jl false
    cmp r10b, '9'
    jg false
    jmp true

is_valid_check:
    cmp r10b, 'x'
    je true
    cmp r10b, 'X'
    je true
    jmp false
    
global is_valid
is_valid:
    ; rdi - input string
    ; output is a boolean passed in rax

    mov rcx, -1 ; input index
    mov r8, 10 ; multiplier
    xor r9, r9 ; accumulator
    xor r10, r10 ; current digit
loop:
    add rcx, 1
    mov r10b, byte [rdi + rcx]

    call is_digit
    cmp rax, 1
    je prepare_value

    cmp r10b, '-'
    je loop

    cmp r8, 1
    je check

    cmp r10b, 0
    jne false

    jmp end

 check:
    call is_valid_check
    cmp rax, 1
    jne false
    mov r10, 10
    jmp sum_value

prepare_value:
    sub r10, '0'
    
sum_value:
    mov rax, r10
    mul r8
    
    sub r8, 1
    add r9, rax
    jmp loop

 end:
    cmp r8, 0
    jne false
    
    xor rdx, rdx
    mov r11, 11
    mov rax, r9
    div r11
    
    cmp rdx, 0
    jne false

true:
    mov rax, 1
    ret

 false:
    mov rax, 0
    ret

%ifidn __OUTPUT_FORMAT__,elf64
section .note.GNU-stack noalloc noexec nowrite progbits
%endif
