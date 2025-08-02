section .text
global factors
factors:
    ; rdi - output array of uint64_t
    ; rsi - value
    ; output array should be modified in place
    ; the size of array is returned in rax

    xor rax, rax
    cmp rsi, 1
    jle end ; no factor for integers less than 2
    
    mov rax, rsi ; dividend
    mov rcx, 2 ; smallest possible factor
loop:
    cmp rcx, rsi 
    jg end ; no factor greater than the number
    
    xor rdx, rdx ; stores remainder
    div rcx
    
    cmp rdx, 0
    je handle_factor ; remainder 0 means rcx is a factor

    mov rax, rsi ; restores dividend
    add rcx, 1 ; increases to next possible factor
    jmp loop
handle_factor:
    mov qword [rdi], rcx ; inserts factor
    
    ; prepares recursion
    add rdi, 8 ; points to next elem in the array
    mov rsi, rax ; next value is quotient

    call factors ; recursively adds next factors
    
    add rax, 1 ; increases size
end:
    ret

%ifidn __OUTPUT_FORMAT__,elf64
section .note.GNU-stack noalloc noexec nowrite progbits
%endif
