section .data
    black db "black", 0
    brown db "brown", 0
    red db "red", 0
    orange db "orange", 0
    yellow db "yellow", 0
    green db "green", 0
    blue db "blue", 0
    violet db "violet", 0
    grey db "grey", 0
    white db "white", 0

    _colors dq black, brown, red, orange, yellow, green, blue, violet, grey, white

section .text
global value
value:
    vpxor xmm0, xmm0
    vmovdqu xmm1, [rdi]
    vmovdqu xmm2, [rsi]
    
    vpcmpistri xmm0, xmm1, 0b00_00_10_00
    mov r8d, ecx                           ; r8d holds first string length
    vpcmpistri xmm0, xmm2, 0b00_00_10_00
    mov r9d, ecx                           ; r9d holds second string length

    lea rsi, [rel _colors]
    mov rdx, -1                            ; idx
.find:
    inc rdx
    
    mov rdi, qword [rsi + 8*rdx]           ; address of current string is in rdi
    
    vpcmpistri xmm1, [rdi], 0b00_11_10_00
    cmp ecx, r8d                           
    cmove r10, rdx                         ; if first differing char is string length, found string
    
    vpcmpistri xmm2, [rdi], 0b00_11_10_00
    cmp ecx, r9d
    cmove r11, rdx                         ; if first differing char is string length, found string
    
    cmp rdx, 9
    jne .find                              ; loops until end of array, to reduce branching

    imul rax, r10, 10
    add rax, r11
    ret

%ifidn __OUTPUT_FORMAT__,elf64
section .note.GNU-stack noalloc noexec nowrite progbits
%endif
