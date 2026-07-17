section .rodata
flower: db '*'
space: db ' '
zero: db '0'
diff: db '0' - ' ' 

section .text
global annotate

%macro count_squares 1-*
    %rep %0
        vpcmpeqb xmm2, xmm3, %1 ; becomes -1 at matching lanes
        vpsubb xmm1, xmm1, xmm2 ; subtracting -1 == adding 1
        %rotate 1
    %endrep
%endmacro

annotate:
    sub rsp, 264
    
    vpxor xmm0, xmm0, xmm0
    vpbroadcastb xmm3, [rel flower]
    vpbroadcastb xmm4, [rel zero]
    vpbroadcastb xmm5, [rel diff] 
    vpbroadcastb xmm6, [rel space]
    
    %assign i 0
    %rep 256 / 16
        vmovdqa [rsp + i], xmm0
        %assign i i + 16
    %endrep

    xor ecx, ecx    ; string length
    xor r10d, r10d  ; row length
    xor r8d, r8d
    xor r9d, r9d
.copy:
    mov al, [rsi + rcx]
    mov [rsp + rcx + 96], al
    inc ecx
    cmp al, 10
    setz r8b
    test r10d, r10d
    setz r9b
    test r8d, r9d
    cmovnz r10d, ecx
    test al, al
    jnz .copy
    xor edx, edx

    lea r8, [rsp + 96]    
    mov r9, r8
    sub r9, r10    
    lea r10, [r8 + r10]    

    dec ecx
    and ecx, -16
.annotate:
    vmovdqa xmm1, xmm4
    count_squares [r8 + rcx - 1], [r8 + rcx + 1], \
                  [r9 + rcx], [r9 + rcx - 1], [r9 + rcx + 1], \
                  [r10 + rcx], [r10 + rcx - 1], [r10 + rcx + 1]
    vpcmpeqb xmm2, xmm1, xmm4
    vpand xmm2, xmm2, xmm5
    vpsubb xmm1, xmm1, xmm2
    vmovdqu xmm7, [r8 + rcx]
    vpcmpeqb xmm0, xmm6, xmm7
    vpblendvb xmm7, xmm1, xmm0
    vmovdqu [rdi + rcx], xmm7
    sub ecx, 16
    jae .annotate

    add rsp, 264
    ret

%ifidn __OUTPUT_FORMAT__,elf64
section .note.GNU-stack noalloc noexec nowrite progbits
%endif
