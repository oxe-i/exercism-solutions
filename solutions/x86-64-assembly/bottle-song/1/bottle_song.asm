section .rodata
    numbers dq "no", "one", "two", "three", "four", "five", "six", "seven", "eight", "nine", "ten"
    num_sizes dq 2, 3, 3, 5, 4, 4, 3, 5, 5, 4, 3

%macro add_bottle 1
    mov rcx, " green b"
    mov qword [rdi], rcx

    mov rcx, "ottles"
    mov qword [rdi + 8], rcx
    lea rcx, [rdi + 14]
    add rdi, 13
    cmp eax, 1
    cmovne rdi, rcx

    mov rcx, " hanging"
    mov qword [rdi], rcx
    mov rcx, " on the "
    mov qword [rdi + 8], rcx
    mov dword [rdi + 16],"wall"
    mov word [rdi + 20], %1
    add rdi, 22
%endmacro

section .text
global recite
recite:    
    mov eax, esi

    lea r8, [rel numbers]
    lea r9, [rel num_sizes]
    mov r10, qword [r8 + 8*rax]
    xor r10, 32
    mov r11, qword [r9 + 8*rax]
%rep 2
    ; add initial number
    mov qword [rdi], r10
    add rdi, r11

    add_bottle `,\n`
%endrep
    mov rcx, "And if o"
    mov qword [rdi], rcx
    mov rcx, "ne green"
    mov qword [rdi + 8], rcx
    mov rcx, " bottle "
    mov qword [rdi + 16], rcx
    mov rcx, "should a"
    mov qword [rdi + 24], rcx
    mov rcx, "ccidenta"
    mov qword [rdi + 32], rcx
    mov rcx, "lly fall"
    mov qword [rdi + 40], rcx
    mov word [rdi + 48], `,\n`

    mov rcx, "There'll"
    mov qword [rdi + 50], rcx

    mov dword [rdi + 58], " be "
    add rdi, 62
    
    mov r10, qword [r8 + 8*rax - 8]
    mov qword [rdi], r10
    add rdi, qword [r9 + 8*rax - 8]

    dec eax
    add_bottle `.\n`

    dec edx
    mov esi, eax    
    inc rdi
    
    mov r8d, `\n`
    xor r9d, r9d
    
    test edx, edx
    cmovz r8d, r9d
    mov byte [rdi - 1], r8b
    jnz recite

    ret

%ifidn __OUTPUT_FORMAT__,elf64
section .note.GNU-stack noalloc noexec nowrite progbits
%endif
