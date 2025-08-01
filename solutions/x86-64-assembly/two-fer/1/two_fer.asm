default rel

section .rodata
    intro db "One for ", 0
    ending db ", one for me.", 0
    defName db "you", 0

section .text
global two_fer
two_fer:
    lea r8, [rdi]
    lea rdi, [rsi]
    cld
    
    lea rsi, [intro]
    movsq

    test r8, r8
    jnz handle_name

    lea rsi, [defName]
    movsd
    
    jmp handle_ending
handle_name:
    lea rsi, [r8]
name_copy:
    lodsb
    stosb
    test al, al
    jnz name_copy
handle_ending:
    sub rdi, 1
    lea rsi, [ending]
    mov rcx, 14
    rep movsb
    ret

%ifidn __OUTPUT_FORMAT__,elf64
section .note.GNU-stack noalloc noexec nowrite progbits
%endif
