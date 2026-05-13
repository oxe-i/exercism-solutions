section .text
global convert

%macro add_sound 2
    imul ecx, edi, 0xFF_FF_FF_FF / %1 + 1
    mov r11, %2
    mov [rsi + rdx], r11
    lea eax, [edx + 5]    
    cmp ecx, 0xFF_FF_FF_FF / %1
    cmovbe edx, eax
%endmacro

%macro stringify 0
    mov r10d, 0xFF_FF_FF_FF / 10 + 1
    xor r11d, r11d
%%loop:
    mov eax, edi
    mul r10d
    lea eax, [edx + 4*edx]
    lea eax, [eax + eax]
    sub edi, eax
    add edi, '0'
    shl r11, 8
    or r11d, edi
    mov edi, edx
    test edi, edi
    jnz %%loop
    mov [rsi], r11
%endmacro

convert:
    xor edx, edx
    add_sound 3, "Pling"
    add_sound 5, "Plang"
    add_sound 7, "Plong"
    mov byte [rsi + rdx], 0
    test edx, edx
    jnz .ret
    stringify
.ret:
    ret

%ifidn __OUTPUT_FORMAT__,elf64
section .note.GNU-stack noalloc noexec nowrite progbits
%endif
