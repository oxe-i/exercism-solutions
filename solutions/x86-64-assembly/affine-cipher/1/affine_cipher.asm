section .text
global encode, decode

encode:
    test edx, 1
    jz .exit    ; divisible by 2

    imul eax, edx, 0xFFFF_FFFF / 13 + 1
    cmp eax, 0xFFFF_FFFF / 13
    jbe .exit    ; divisible by 13

    mov r8d, edx
    xor r9d, r9d ; num of letters in chunk
    mov r10d, 26
.repeat:
    movzx eax, byte [rsi]
    test eax, eax
    jz .exit
    inc rsi
    mov edx, eax
    sub edx, '0'
    cmp edx, 10
    jb .store
    or eax, 32
    sub eax, 'a'
    cmp eax, 26
    jae .repeat
    imul eax, r8d
    add eax, ecx
    imul eax, eax, 0xFFFF_FFFF / 26 + 1
    mul r10d
    lea eax, [edx + 'a']
.store:
    mov byte [rdi], ' '
    lea r11, [rdi + 1]
    xor edx, edx
    cmp r9d, 5
    cmove r9d, edx
    cmove rdi, r11
    stosb
    inc r9d
    jmp .repeat
.exit:
    mov byte [rdi], 0
    ret

decode:
    push rbx
    
    test edx, 1
    jz .exit    ; divisible by 2

    imul eax, edx, 0xFFFF_FFFF / 13 + 1
    cmp eax, 0xFFFF_FFFF / 13
    jbe .exit    ; divisible by 13

    mov r8d, edx
.repeat:
    movzx eax, byte [rsi]
    test eax, eax
    jz .exit

    inc rsi

    mov edx, eax
    sub edx, '0'
    cmp edx, 10
    jb .store

    mov r9d, eax
    sub r9d, 'a'
    cmp r9d, 26
    jae .repeat
    sub r9d, ecx

    mov r10d, 26
    mov eax, r8d
    mov ebx, 1
    xor r11d, r11d
.mmi:
    test r10d, r10d
    jz .end_mmi

    cdq
    div r10d

    imul eax, r11d
    sub ebx, eax
    xchg ebx, r11d
    
    mov eax, r10d
    mov r10d, edx
    jmp .mmi
    
.end_mmi:
    imul ebx, r9d
    mov eax, ebx
    mov r10d, 26
    cdq
    idiv r10d

    lea eax, [edx + r10d]
    imul eax, eax, 0xFFFF_FFFF / 26 + 1
    mul r10d
    lea eax, [edx + 'a']
.store:
    stosb
    jmp .repeat
    
.exit:
    mov byte [rdi], 0
    pop rbx
    ret

%ifidn __OUTPUT_FORMAT__,elf64
section .note.GNU-stack noalloc noexec nowrite progbits
%endif
