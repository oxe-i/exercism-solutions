section .text
global reverse
reverse:
    ; assumes the string's length <= 15
    ; assumes `rdi` has 16 readable bytes, even though they are after the string's end
    
    vmovdqu8 xmm0, [rdi]
    vptestnmb k1, xmm0, xmm0  ; k1 has bit sets where the byte is NUL
    kmovd eax, k1             
    tzcnt ecx, eax            ; index of first bit set is length of the string (n)
    blsmsk eax, eax           ; sets bits up to index, clears the rest
    btr eax, ecx              ; clears index bit
    kmovd k1, eax             ; store mask
    lea eax, [rcx-1]          ; significant bytes not include NUL       
    vpbroadcastb xmm2, eax    ; all bytes in xmm2 are now n - 1
    vpsubb xmm1, xmm2, [rel iota] ; xmm1 now has (n - 1) - i. For i > n, this is negative
    vpshufb xmm0, xmm0, xmm1  ; shuffles bytes according to xmm1 positions. For numbers < 0, the bytes are 0
    vmovdqu8 [rdi]{k1}, xmm0  ; writes only the bytes in xmm0 whose correspondent bits are set in k1
    ret

section .rodata
align 16
iota: db 0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15

%ifidn __OUTPUT_FORMAT__,elf64
section .note.GNU-stack noalloc noexec nowrite progbits
%endif
