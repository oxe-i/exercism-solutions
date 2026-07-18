section .rodata
flower: db '*'
space: db ' '
zero: db '0'
newline: db 10

section .text
global annotate

%macro count_squares 1-*
    %rep %0
        ; xmm1 is counter
        ; xmm3 is flowers
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
    vpbroadcastb xmm5, [rel space]
    vpbroadcastb xmm6, [rel newline]

    ; zeroes-out the stack
    %assign i 0
    %rep 256 / 16
        vmovdqa [rsp + i], xmm0
        %assign i i + 16
    %endrep

    mov r11, rsi    
    and rsi, -16 ; 16-byte aligned, safe to load
    and r11, 15  ; slack before the string
    
    lea rdx, [rsp + 96]
    sub rdx, r11 ; string will start at rsp + 96

    mov ecx, r11d
    mov eax, -1
    shl eax, cl  ; mask to clear out slack
    
    mov ecx, -16 ; string length
.strlen:
    add ecx, 16
    vmovdqa xmm1, [rsi + rcx]
    vmovdqu [rdx + rcx], xmm1 ; copy string to stack
    vpcmpeqb xmm2, xmm1, xmm0
    vpmovmskb r8d, xmm2
    and r8d, eax ; mask-out slack in first iteration
    mov eax, -1  ; does not change flags
    jz .strlen   ; repeat until NUL found

    tzcnt r8d, r8d
    add ecx, r8d
    sub ecx, r11d ; remove slack count

    vmovdqu [rsp + 96 + rcx], xmm0 ; clear slack before
    vmovdqa [rsp + 80], xmm0 ; clear slack after

    xor r10d, r10d  ; rowlen is 0 if strlen == 0
    
    test ecx, ecx
    jz .skip_rowlen ; allows a tighter loop with just 1 branch
    
    mov r10d, -16
.rowlen:
    add r10d, 16
    vpcmpeqb xmm2, xmm6, [rsp + 96 + r10]
    vptest xmm2, xmm2
    jz .rowlen ; repeat until \n found

    vpmovmskb eax, xmm2
    tzcnt eax, eax
    lea r10d, [r10d + eax + 1] ; 1 more to account for \n

.skip_rowlen:
    lea r8, [rsp + 96]  ; start of first row
    mov r9, r8 
    sub r9, r10         ; start of prev row
    lea r10, [r8 + r10] ; start of next row

    and ecx, -16        ; last 16-byte chunk pos
.annotate:
    vmovdqa xmm1, xmm4  ; xmm1 starts stringified
    count_squares [r8 + rcx - 1], [r8 + rcx + 1], \
                  [r9 + rcx], [r9 + rcx - 1], [r9 + rcx + 1], \
                  [r10 + rcx], [r10 + rcx - 1], [r10 + rcx + 1]
    ; xmm1 now holds the stringified count
    vpcmpeqb xmm2, xmm1, xmm4 ; mask for zero-count lanes
    vpblendvb xmm1, xmm1, xmm5, xmm2 ; where zero-count, insert space, otherwise keep count 
    ; xmm1 is now formatted
    
    vmovdqu xmm7, [r8 + rcx] ; original row
    vpcmpeqb xmm0, xmm5, xmm7 ; gets spaces
    vpblendvb xmm7, xmm7, xmm1, xmm0 ; where space, insert formatted cell, otherwise keep original value
    vmovdqu [rdi + rcx], xmm7 ; store
    sub ecx, 16
    jae .annotate

    add rsp, 264
    ret

%ifidn __OUTPUT_FORMAT__,elf64
section .note.GNU-stack noalloc noexec nowrite progbits
%endif
