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
global color_code
color_code:
    ; strlen
    vpxor xmm1, xmm1
    vpcmpistri xmm1, [rdi], 0b00_00_10_00 ; gets index of the first equal byte. Since xmm1 is empty, it is the index for NUL
    mov edx, ecx                          ; edx now has the length 
    
    lea rsi, [rel _colors]
    mov eax, -1
.find_color:
    inc eax
    mov rcx, qword [rsi + 8*rax]
    vmovdqu xmm1, [rcx]
    vpcmpistri xmm1, [rdi], 0b00_11_10_00 ; compares byte-wise for inequality, ignoring chars starting at NUL
    cmp ecx, edx
    jne .find_color                       ; if the first differing char is the length, found the color
    ret

global colors
colors:
    lea rax, [rel _colors]
    ret

%ifidn __OUTPUT_FORMAT__,elf64
section .note.GNU-stack noalloc noexec nowrite progbits
%endif
