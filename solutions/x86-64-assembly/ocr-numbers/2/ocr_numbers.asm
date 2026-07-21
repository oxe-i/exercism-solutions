section .rodata
align 32
numbers: dd 0x0002E88C, 0x00020800, 0x0000EB0C
         dd 0x0002CB0C, 0x00020B80, 0x0002C38C
         dd 0x0002E38C, 0x0002080C, 0x0002EB8C
         dd 0x0002CB8C
         times 6 dd -1
         
comp: db "0123456789??????"

section .text
global convert

convert:
    test rdx, 3
    jnz .invalid_lines

    vpxor xmm0, xmm0, xmm0
    mov r8, [rsi]
    mov rcx, r8
    and rcx, 15
    and r8, -16
    mov eax, -1
    shl eax, cl
    
    mov r9d, -16
.strlen:
    add r9d, 16
    vpcmpeqb xmm1, xmm0, [r8 + r9]
    vpmovmskb r10d, xmm1
    and r10d, eax
    mov eax, -1
    jz .strlen
    
    tzcnt r10d, r10d
    sub r9d, ecx
    lea ecx, [r9d + r10d]
    
    imul r9d, ecx, 0xFFFFFFFF / 3 + 1
    cmp r9d, 0xFFFFFFFF / 3
    ja .invalid_column
    
    push r12
    push r13
    push r14
    push rbx
        
    mov r14d, 0x00060606
    vmovdqa ymm2, [rel numbers]
    vmovdqa ymm3, [rel numbers + 32]
    lea r13, [rel comp]
    
.parse_lines:
    mov r9 , [rsi + 24]
    mov r10, [rsi + 16]
    mov r11, [rsi + 8]
    mov r12, [rsi]

    xor ebx, ebx
.parse_columns:
    xor eax, eax
    
    %assign i 9
    %rep 4
      mov r8d, [r %+ i + rbx]
      pext r8d, r8d, r14d
      shl eax, 6
      or eax, r8d
      %assign i i + 1
    %endrep

    vmovd xmm4, eax
    vpbroadcastd ymm4, xmm4
    vpcmpeqd ymm5, ymm4, ymm2
    vpcmpeqd ymm6, ymm4, ymm3
    vmovmskps eax, ymm5
    vmovmskps r8d, ymm6
    shl r8d, 8
    or eax, r8d
    or eax, 0x8000
    tzcnt eax, eax
    movzx eax, byte [r13 + rax]
    mov [rdi], al
    inc rdi
      
    add ebx, 3
    cmp ebx, ecx
    jb .parse_columns

    mov byte [rdi], ','
    inc rdi
    add rsi, 32
    sub rdx, 4
    jnz .parse_lines

    xor eax, eax
    mov byte [rdi - 1], al

    pop rbx
    pop r14
    pop r13
    pop r12
    vzeroupper
    ret

.invalid_column:
    mov eax, 2
    ret
    
.invalid_lines:
    mov eax, 1
    ret

%ifidn __OUTPUT_FORMAT__,elf64
section .note.GNU-stack noalloc noexec nowrite progbits
%endif
