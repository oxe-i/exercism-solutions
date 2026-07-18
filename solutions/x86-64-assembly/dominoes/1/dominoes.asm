section .text
global can_chain

can_chain:
    mov eax, 1
    
    test rdi, rdi
    jz .done
    
    xor r8d, r8d
    xor r9d, r9d
    mov r10, 0x0040201008040201
.loop:
    movzx ecx, word [rsi + 4*rdi - 4]
    movzx edx, word [rsi + 4*rdi - 2]

    lea r11d, [ecx * 8]
    shrx r11, r10, r11
   
    lea eax, [edx * 8]
    shrx rax, r10, rax

    or r11d, eax
    and r11d, 0xFF

    mov eax, 1
    shlx ecx, eax, ecx
    shlx edx, eax, edx
    xor r8d, ecx
    xor r8d, edx
    or r9d, ecx
    or r9d, edx

    mov rdx, 0x0101010101010101
    pdep rdx, r11, rdx
    imul rdx, r11
    or r10, rdx
    
    dec rdi
    jnz .loop

    xor eax, eax
    test r8d, r8d
    setz al
    
    tzcnt ecx, r9d
    shl ecx, 3
    shr r10, cl
    and r10d, 0xFF
    
    xor edx, edx
    cmp r10d, r9d
    setz dl
    
    and al, dl
.done:      
    ret

%ifidn __OUTPUT_FORMAT__,elf64
section .note.GNU-stack noalloc noexec nowrite progbits
%endif
