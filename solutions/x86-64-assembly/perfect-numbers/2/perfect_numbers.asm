DEFICIENT equ 1
PERFECT equ 2
ABUNDANT equ 3
INVALID equ -1

section .text
global classify
classify:
    ; rdi - number as int64_t
    ; output is a code returned in eax

    cmp rdi, 1
    jl invalid
    je deficient
    
    mov r8, 0
    mov rcx, rdi    
loop:
    dec rcx
get_factors:
    xor rdx, rdx
    mov rax, rdi
    div rcx
    cmp rdx, 0
    jne loop
    add r8, rcx
    loop get_factors
end:
    cmp r8, rdi
    ja abundant
    je perfect
deficient:
    mov rax, DEFICIENT
    ret
abundant:
    mov rax, ABUNDANT
    ret
perfect:
    mov rax, PERFECT
    ret
invalid:
    mov eax, INVALID
    ret

%ifidn __OUTPUT_FORMAT__,elf64
section .note.GNU-stack noalloc noexec nowrite progbits
%endif
