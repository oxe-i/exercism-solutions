section .rodata
    you db "you", 0

section .text
global two_fer
two_fer:
    ; Provide your implementation here
    ; The function has type signature void two_fer(const char *name, char *buffer)
    ; It has no return value
    ; The first argument is of type const char*, which is the address of a read-only NUL-terminated sequence of bytes stored in memory
    ; In the sequence of bytes whose address is passed in the first
    ; The second argument is of type char*, which is the address of a writable sequence of bytes stored in memory

    xchg rdi, rsi
    mov rax, "One for "    
    stosq

    lea r8, [rel you]   
    test rsi, rsi
    cmovz rsi, r8
.store_name:
    lodsb
    stosb
    test al, al
    jnz .store_name

    mov rax, ", one fo"
    mov qword [rdi - 1], rax
    mov rax, "r me."
    mov qword [rdi + 7], rax
    ret

%ifidn __OUTPUT_FORMAT__,elf64
section .note.GNU-stack noalloc noexec nowrite progbits
%endif
