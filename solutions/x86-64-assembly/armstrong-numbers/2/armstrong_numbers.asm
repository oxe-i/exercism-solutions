section .text
global is_armstrong_number
is_armstrong_number:
    mov rsi, 0xFFFFFFFFFFFFFFFF / 10 + 1
    mov eax, edi
    mov r11d, edi
    sub rsp, 16
    
    xor r9d, r9d
.get_digits:
    mov ecx, eax
    mul rsi
    lea edi, [edx + 4*edx]
    shl edi, 1
    sub ecx, edi
    mov byte [rsp + r9], cl
    inc r9
    mov eax, edx
    test edx, edx
    jnz .get_digits

    mov ecx, r9d
    neg rcx
    lea rsi, [rsp + r9]
    xor edx, edx
.accum:
    movzx edi, byte [rsi + rcx]
    mov rax, 1
    mov r8d, r9d
.pow:
    imul rax, rdi   
    dec r8d
    jnz .pow

    add rdx, rax
    inc rcx
    jnz .accum

    add rsp, 16
    xor eax, eax
    cmp edx, r11d
    setz al
    ret

%ifidn __OUTPUT_FORMAT__,elf64
section .note.GNU-stack noalloc noexec nowrite progbits
%endif
