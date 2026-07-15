section .text
global rotate
rotate:
    push r12
    
    mov r12, rdx
    mov r10, 0xFF_FF_FF_FF_FF_FF_FF_FF / 26 + 1
    mov r11, 26
.loop:
    movzx ecx, byte [rdi]
    inc rdi
    
    mov edx, ecx
    or edx, 32
    
    lea r8d, [edx - 'a']    
    lea eax, [r8d + esi]
    mul r10
    mul r11
    
    lea eax, [edx + 'A']
    lea r9d, [edx + 'a']
    bt ecx, 5
    cmovc eax, r9d

    cmp r8d, 26
    cmovae eax, ecx

    mov byte [r12], al
    inc r12
    
    test ecx, ecx
    jnz .loop

    pop r12
    ret

%ifidn __OUTPUT_FORMAT__,elf64
section .note.GNU-stack noalloc noexec nowrite progbits
%endif
