section .rodata
    question db "Sure.", 0
    yell db "Whoa, chill out!", 0
    yelled_question db "Calm down, I know what I'm doing!", 0
    silence db "Fine. Be that way!", 0
    default_answer db "Whatever.", 0

section .text 
global response
response:
    ; rdi - input string
    ; output string is passed in rax

    mov eax, 0xFF       ; is yell
    xor esi, esi        ; is question
    mov ecx, 1          ; is silence
    mov r11, 1          ; for CMOV     
.repeat:
    movzx edx, byte [rdi]
    test edx, edx
    jz .end

    inc rdi

    cmp edx, '?'
    cmove esi, r11d  ; activates if question
    
    mov r8d, edx
    sub r8d, 9
    cmp r8d, 4
    setbe r8b
    cmp edx, ' '
    sete r9b
    or r8b, r9b
    jnz .repeat      ; if whitespace, nothing changes

    xor ecx, ecx     ; if not whitespace, clears silence 
    
    bts edx, 5
    setnc r9b
    sub edx, 'a'
    cmp edx, 26
    jae .repeat

    xor esi, esi     ; if letter, clears question
    and al, r9b
    jmp .repeat
.end:
    lea r11, [rel default_answer]

    inc al
    shr al, 1
    
    lea rdx, [rel yell]
    andn r8d, esi, eax
    cmovnz r11, rdx
    
    lea rdx, [rel question]
    andn r8d, eax, esi
    cmovnz r11, rdx

    lea rdx, [rel yelled_question]
    and esi, eax
    cmovnz r11, rdx
    
    lea rdx, [rel silence]
    test ecx, ecx
    cmovnz r11, rdx
    
    mov rax, r11
    ret

%ifidn __OUTPUT_FORMAT__,elf64
section .note.GNU-stack noalloc noexec nowrite progbits
%endif
