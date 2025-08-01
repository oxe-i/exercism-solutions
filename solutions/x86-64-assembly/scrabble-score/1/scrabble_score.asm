default rel

section .rodata
    scores dd 1, 3, 3, 2, 1, 4, 2, 4, 1, 8, 5, 1, 3, 1, 1, 3, 10, 1, 1, 1, 1, 4, 4, 8, 4, 10

section .text

%macro accumulate_letter 1
    sub r8b, %1
    add r10d, dword [rsi + 4 * r8]
    jmp loop
%endmacro

is_upper:
    cmp r8b, 'A'
    jl false
    cmp r8b, 'Z'
    jg false
    jmp true

is_lower:
    cmp r8b, 'a'
    jl false
    cmp r8b, 'z'
    jg false
    jmp true

false:
    mov rax, 0
    ret

true:
    mov rax, 1
    ret

global score
score:
    ; rdi - input string
    ; output is an int in eax

    lea rsi, [scores]
    mov rcx, -1 ; counter
    xor r10, r10 ; accumulator
    xor r8, r8 
    
loop:

    add rcx, 1 ; increase counter
    mov r8b, byte [rdi + rcx] ; current char
    
    cmp r8b, 0
    je end ; end of string
    
    call is_upper
    cmp rax, 1
    je handle_upper
    
    call is_lower
    cmp rax, 1
    je handle_lower

    jmp loop
    
handle_upper: accumulate_letter 'A'
handle_lower: accumulate_letter 'a'
    
end:
    mov rax, r10
    ret

%ifidn __OUTPUT_FORMAT__,elf64
section .note.GNU-stack noalloc noexec nowrite progbits
%endif
