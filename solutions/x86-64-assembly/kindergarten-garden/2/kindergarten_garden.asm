section .rodata
.plants: dq 0, 0, "radishes", "clover", 0, 0, "violets", "grass"
         dq 0, 0, 8, 6, 0, 0, 7, 5

section .text
global plants

%macro insert_plant 1
    and %1, 7
    mov r8, [r11 + 8*%1]
    mov r9, [r11 + 8*%1 + 64]
            
    mov [rdi], r8
    mov word [rdi + r9], ", "
    lea rdi, [rdi + r9 + 2]
%endmacro

%macro insert_row 1
    movzx eax, word [%1 - 2]
    mov edx, eax
    shr edx, 8

    insert_plant rax
    insert_plant rdx
%endmacro

plants:
    xor ecx, ecx
.find_row_length:
    movzx eax, byte [rsi + rcx]
    inc rcx
    cmp eax, 10
    jnz .find_row_length
    
    movzx edx, byte [rdx]
    and edx, 31    

    lea rsi, [rsi + 2*rdx]
    lea r11, [rel .plants]

    insert_row rsi
    insert_row rsi + rcx
    
    mov byte [rdi - 2], 0
    ret

%ifidn __OUTPUT_FORMAT__,elf64
section .note.GNU-stack noalloc noexec nowrite progbits
%endif
