section .rodata
you: db ", you are the "
customer: db " customer we serve today. Thank "

section .text
global format

format:
    vmovdqu xmm0, [rsi]
    vptestnmb k1, xmm0, xmm0
    kmovd eax, k1
    tzcnt eax, eax
    mov ecx, -1
    bzhi ecx, ecx, eax
    kmovd k1, ecx
    vmovdqu8 [rdi]{k1}, xmm0
    add rdi, rax

    vmovdqu xmm0, [rel you]
    vmovdqu [rdi], xmm0
    add rdi, 14

    xor r8d, r8d
    movzx eax, dx
    mov r9d, 0xFFFFFFFF / 10 + 1
.stringify:
    mov r10d, eax
    mul r9d
    lea ecx, [edx + 4*edx]
    lea ecx, [ecx + ecx]
    sub r10d, ecx
    shl r8, 8
    lea r8, [r8 + r10 + '0']
    mov eax, edx
    test eax, eax
    jnz .stringify

    mov [rdi], r8
    lzcnt r9, r8
    shr r9, 3
    mov eax, 8
    sub eax, r9d
    add rdi, rax

    xor r8d, r8d
    xor r9d, r9d
    xor r10d, r10d
    xor r11d, r11d
    
    movzx ecx, byte [rdi - 1]    
    sub ecx, '0'
    cmp ecx, 1
    sete r8b
    cmp ecx, 2
    sete r9b
    cmp ecx, 3
    sete r10b

    movzx ecx, byte [rdi - 2]
    sub ecx, '0'
    cmp ecx, 1
    sete r11b

    mov edx, "th"
    mov eax, "st"
    andn r8d, r11d, r8d
    cmovnz edx, eax
    mov eax, "nd"
    andn r9d, r11d, r9d
    cmovnz edx, eax
    mov eax, "rd"
    andn r10d, r11d, r10d
    cmovnz edx, eax

    mov [rdi], edx
    vmovdqu xmm0, [rel customer]
    vmovdqu [rdi + 2], xmm0
    vmovdqu xmm0, [rel customer + 16]
    vmovdqu [rdi + 18], xmm0
    mov qword [rdi + 34], "you!"
    ret

%ifidn __OUTPUT_FORMAT__,elf64
section .note.GNU-stack noalloc noexec nowrite progbits
%endif
