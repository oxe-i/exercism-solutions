section .text

global square_root

bsearch:
    mov r9, r8
    add r9, r10
    shr r9, 1 ; mid
    mov rax, r9
    mul rax
    cmp rax, rdi
    jg set_high
    jl set_low
    mov rax, r9
    ret

set_high:
    mov r10, r9
    sub r10, 1
    jmp bsearch

set_low:
    mov r8, r9
    add r8, 1
    jmp bsearch
      
square_root:
    mov r10, rdi ; high
    mov r8, 1 ; low
    call bsearch
    ret

%ifidn __OUTPUT_FORMAT__,elf64
section .note.GNU-stack noalloc noexec nowrite progbits
%endif
