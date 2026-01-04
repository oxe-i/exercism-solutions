section .text
global encode, decode

encode:
    lodsb
    test al, al
    jz .exit
    
    xchg rsi, rdi
    mov rcx, -1
    rep scasb
    not rcx
    
    xchg rsi, rdi
    dec rsi
    
    cmp rcx, 1
    je .store_letter

    mov r9b, al
    mov eax, ecx
    mov ecx, (0xFFFFFFFF / 10) + 1
    mov r10d, 10
    mov r11, rsp
.get_digits:
    mul ecx
    mov r8d, edx
    mul r10d
    add dl, '0'
    dec rsp
    mov byte [rsp], dl
    mov eax, r8d
    test eax, eax
    jnz .get_digits

    mov r10, rsi
    mov rcx, r11
    sub rcx, rsp
    mov rsi, rsp
    rep movsb

    mov rsp, r11
    mov rsi, r10
    mov al, r9b
    
.store_letter:
    stosb
    jmp encode
.exit:
    stosb
    ret

decode:
    xor eax, eax
    lodsb
    test al, al
    jz .exit

    mov ecx, 1
    lea edx, [eax - '0']
    cmp edx, 10
    cmovb ecx, edx
    jnb .store

.find_num:
    lodsb
    lea edx, [eax - '0']
    lea r8d, [ecx + ecx]
    lea r8d, [r8d + 4*r8d]
    add r8d, edx
    cmp edx, 10
    cmovb ecx, r8d
    jb .find_num

.store:
    rep stosb
    jmp decode
.exit:
    stosb
    ret

%ifidn __OUTPUT_FORMAT__,elf64
section .note.GNU-stack noalloc noexec nowrite progbits
%endif
