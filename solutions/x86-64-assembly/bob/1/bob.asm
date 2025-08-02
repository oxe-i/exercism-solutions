default rel

section .rodata
    question db "Sure.", 0
    yell db "Whoa, chill out!", 0
    yelled_question db "Calm down, I know what I'm doing!", 0
    silence db "Fine. Be that way!", 0
    default_answer db "Whatever.", 0

section .text 

is_upper:
    xor rax, rax
    cmp dl, 'A'
    jl upper_end
    cmp dl, 'Z'
    jg upper_end
    mov rax, 1
upper_end:
    ret

is_lower:
    xor rax, rax
    cmp dl, 'a'
    jl lower_end
    cmp dl, 'z'
    jg lower_end
    mov rax, 1
lower_end:
    ret

is_question:
    xor rax, rax
    cmp dl, '?'
    jne question_end
    mov rax, 1
question_end:
    ret

is_whitespace:
    xor rax, rax
    cmp dl, ' '
    je whitespace_true
    cmp dl, 9
    je whitespace_true
    cmp dl, 10
    je whitespace_true
    cmp dl, 12
    je whitespace_true
    cmp dl, 13
    je whitespace_true
    ret
whitespace_true:
    mov rax, 1
    ret

is_digit:
    xor rax, rax
    cmp dl, '0'
    jl digit_end
    cmp dl, '9'
    jg digit_end
    mov rax, 1
digit_end:
    ret

set_whitespace:
    and r9, r9
    jmp fill_loop

set_upper:
    cmp r10, 0
    setnl r10b
    xor r9, r9
    mov r11b, dl
    jmp fill_loop

set_question:
    mov r11b, dl
    jmp fill_loop

set_lower:
    xor r9, r9
    mov r10, -1
    mov r11b, dl
    jmp fill_loop

set_digit:
    xor r9, r9
    jmp fill_loop
    
global response
response:
    ; rdi - input string
    ; output string is passed in rax

    mov rcx, -1 ; input index
    mov r9, 1 ; all whitespace?
    xor r10, r10 ; all capitals?
    xor r11, r11 ; last significant char
fill_loop:
    inc rcx
    mov dl, byte [rdi + rcx] ; current letter
    
    call is_whitespace
    cmp rax, 1
    je set_whitespace

    call is_upper
    cmp rax, 1
    je set_upper    

    call is_question
    cmp rax, 1
    je set_question

    call is_lower
    cmp rax, 1
    je set_lower

    call is_digit
    cmp rax, 1
    je set_digit

    cmp dl, 0
    jne fill_loop
end_loop:     
    cmp r11, '?'
    sete r8b

    cmp r10b, 1
    jne not_yell

    test r8b, r8b
    jnz handle_yelled_question
    jmp handle_yell
    
not_yell:
    test r8b, r8b
    jnz handle_question

    cmp r9b, 1
    je handle_silence

    lea rax, [default_answer]
    ret
    
handle_silence:
    lea rax, [silence]
    ret
handle_question:
    lea rax, [question]
    ret
handle_yelled_question:
    lea rax, [yelled_question]
    ret
handle_yell:
    lea rax, [yell]
    ret

%ifidn __OUTPUT_FORMAT__,elf64
section .note.GNU-stack noalloc noexec nowrite progbits
%endif
