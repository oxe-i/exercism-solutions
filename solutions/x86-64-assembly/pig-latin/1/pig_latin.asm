section .text
global translate
translate:
    xor ecx, ecx

    movzx eax, word [rsi]
    
    cmp eax, "xr"
    jz .copy
    cmp eax, "yt"
    jz .copy
    
    and eax, 0xFF
    sub eax, 'a'
    mov edx, 0b00000100000100000100010001
    
    bt edx, eax
    jc .copy  

    or edx, 1 << 24 ; add 'y' to vowels
.find_vowel:
    inc ecx
    movzx eax, byte [rsi + rcx]
    or eax, 32
    sub eax, 'a'
    bt edx, eax
    jnc .find_vowel

    xor r9d, r9d
    xor r10d, r10d
    
    cmp eax, 20
    setz r9b
    cmp byte [rsi + rcx - 1], 'q'
    setz r10b
    
    and r9d, r10d
    add ecx, r9d
.copy:
    mov r8d, ecx
.tail:
    movzx eax, byte [rsi + r8]
    inc r8
    mov byte [rdi], al
    inc rdi
    or eax, 32
    sub eax, 'a'
    cmp eax, 26
    jb .tail

    dec rdi
    lea r10, [rsi + r8]
    
    rep movsb

    mov word [rdi], "ay"
    add rdi, 2

    mov rsi, r10
    movzx eax, byte [rsi - 1]
    mov byte [rdi], al
    inc rdi
    
    test eax, eax
    jnz translate
    
    ret

%ifidn __OUTPUT_FORMAT__,elf64
section .note.GNU-stack noalloc noexec nowrite progbits
%endif
