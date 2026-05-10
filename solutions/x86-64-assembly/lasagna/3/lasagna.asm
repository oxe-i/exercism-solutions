; Everything that comes after a semicolon (;) is a comment

%include "debug.mac"

TIME_IN_OVEN equ 40

section .text

global expected_minutes_in_oven
expected_minutes_in_oven:
    mov rax, 40
    debugd8 al
    ret

global remaining_minutes_in_oven
remaining_minutes_in_oven:
    neg rdi
    lea rax, [rdi + TIME_IN_OVEN]
    ret

global preparation_time_in_minutes
preparation_time_in_minutes:
    imul rax, rdi, 2
    ret

global elapsed_time_in_minutes
elapsed_time_in_minutes:
    lea rax, [rsi + 2*rdi]
    ret

%ifidn __OUTPUT_FORMAT__,elf64
section .note.GNU-stack noalloc noexec nowrite progbits
%endif
