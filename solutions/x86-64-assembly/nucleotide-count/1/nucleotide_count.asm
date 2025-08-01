section .text
global nucleotide_counts
nucleotide_counts:
    ; contract is
    ; rdi is an input string
    ; rsi is an output counter array
    ; the function counts the number of nucleotides (ACGT)
    ; in case of error, all values are initialized to -1
    ; output array is modified in place

    ; function uses stack based string for comparison
    ; because compilation options forbid reading .data or .rodata
    ; from a variable index (such as one from a number stored in a register)
    ; so for instance [nucleotides + rax] is not allowed, although [nucleotides] is
    push rbp
    mov rbp, rsp
    sub rsp, 4
    
    mov byte [rbp - 4], 'A'
    mov byte [rbp - 3], 'C'
    mov byte [rbp - 2], 'G'
    mov byte [rbp - 1], 'T'

    ; zero initializes the output array
    mov qword [rsi], 0
    mov qword [rsi + 8], 0
    mov qword [rsi + 16], 0
    mov qword [rsi + 24], 0
    
    xor rcx, rcx ; counter
loop:
    mov al, byte [rdi + rcx] ; current char on string
    cmp al, 0 
    je end ; end of string
    mov r8, -1 ; counter for looping over stack array
index:
    add r8, 1
    cmp r8, 4
    je error ; current char doesn't match any valid nucleotide
    cmp byte [rbp - 4 + r8], al
    jne index ; current char doesn't match current nucleotide, move to the next
    add qword [rsi + 8 * r8], 1 ; found match, increase counter
    add rcx, 1
    jmp loop
error:
    mov qword [rsi], -1
    mov qword [rsi + 8], -1
    mov qword [rsi + 16], -1
    mov qword [rsi + 24], -1
end:
    ; restore call frame
    mov rsp, rbp
    pop rbp
    ret
    
%ifidn __OUTPUT_FORMAT__,elf64
section .note.GNU-stack noalloc noexec nowrite progbits
%endif
