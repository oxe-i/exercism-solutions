default rel

ONGOING equ 0
DRAW equ 1
WIN equ 2
INVALID equ 3

section .bss
    crosses resb 1
    naughts resb 1

section .data
    true db 1

section .text

%macro count_sequence 3
    xor rdx, rdx ; collects values
    xor r8, r8 ; naughts
    xor r9, r9 ; crosses
    
    mov rsi, rdi
    add rsi, %1
    mov rcx, 3
%%seq:
    lodsb

    cmp al, 'O'
    sete dl
    add r8b, dl

    cmp al, 'X'
    sete dl
    add r9b, dl

    add rsi, %2
    
    loop %%seq

    cmp r8b, 3
    sete dl
    add r10, rdx

    cmp r9b, 3
    sete dl
    add r11, rdx

    xor rax, rax
    xor rcx, rcx

    cmp byte [true], %3
    cmove rax, r8
    cmove rcx, r9

    add byte [naughts], al
    add byte [crosses], cl
%endmacro

%macro epilogue 0
    mov rsp, rbp
    pop rbp
%endmacro

global gamestate
gamestate:
    push rbp
    mov rbp, rsp
    sub rsp, 9

    mov r10, rdi
    lea rdi, [rbp - 9]
    mov rsi, [r10]
    xor rax, rax
flatten_array:
    mov rcx, 3
    rep movsb
    add r10, 8
    mov rsi, [r10]
    inc rax
    cmp rax, 3
    jl flatten_array

    lea rdi, [rbp - 9]

    xor r10, r10 ; naughts wins
    xor r11, r11 ; crosses wins

    mov byte [crosses], 0
    mov byte [naughts], 0

    count_sequence 0, 0, 1 ; count first row
    count_sequence 3, 0, 1 ; count second row
    count_sequence 6, 0, 1 ; count third row
    count_sequence 0, 2, 0 ; count first col
    count_sequence 1, 2, 0 ; count second col
    count_sequence 2, 2, 0 ; count third col
    count_sequence 0, 3, 0 ; count first diagonal
    count_sequence 2, 1, 0 ; count second diagonal

    mov r9b, byte [crosses]
    sub r9b, byte [naughts]
    cmp r9, 0
    jl invalid ; can't have more naughts than crosses
    
    cmp r9, 1
    jg invalid ; crosses can only be one turn ahead of naughts

    cmp r10, 0
    setg al ; set if at least one naught win
          
    cmp r11, 0
    setg cl ; set if at least one cross win

    mov dl, al
    and dl, cl
    jnz invalid ; naught and cross can't win at the same time

    xor al, cl
    jnz win ; one of the two is a win

    mov r9b, byte [crosses]
    add r9b, byte [naughts]
    cmp r9, 9
    je draw ; all squares are occupied

    mov rax, ONGOING
    epilogue
    ret
invalid:
    mov rax, INVALID
    epilogue
    ret
win:
    mov rax, WIN
    epilogue
    ret
draw:
    mov rax, DRAW
    epilogue
    ret

%ifidn __OUTPUT_FORMAT__,elf64
section .note.GNU-stack noalloc noexec nowrite progbits
%endif
