section .text
global square
square:
    ; contract is
    ; rdi is the num of the square
    ; output is passed in rax as unsigned
    
    cmp rdi, 0
    jle exception

    cmp rdi, 64
    jg exception
    
    sub rdi, 1
    mov rcx, rdi
    mov rax, 1
    shl rax, cl
    ret

exception:
    mov rax, 0
    ret

global total
total:
    ; contract is
    ; output is passed in rax
    mov rax, -1
    ret

%ifidn __OUTPUT_FORMAT__,elf64
section .note.GNU-stack noalloc noexec nowrite progbits
%endif
