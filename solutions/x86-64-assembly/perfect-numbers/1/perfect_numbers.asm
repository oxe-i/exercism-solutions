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
    
    mov r8, 1
    mov rcx, 1
get_factors:
    mov rax, rdi
    add rcx, 1
    cmp rcx, rax
    jge end
    xor rdx, rdx
    div rcx
    cmp rdx, 0
    jne get_factors
    add r8, rcx
    jmp get_factors
end:
    cmp r8, rdi
    jg abundant
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
