section .rodata
align 32
mask: times 32 db -65

section .text
global truncate
truncate:
    ; For 5 UTF8, the max number of bytes is
    ; max = 5 * 4 = 20
    ; It fits in a YMM register (32-byte size)
    ;
    ; The buffer has capacity 40
    ; so it is safe to store using YMM
    ;
    ; We are considering that loading the input
    ; does not cross a page boundary
    
    vpxor ymm1, ymm1, ymm1
    vmovdqu [rdi], ymm1  ; inserts NUL
    
    vmovdqu ymm0, [rsi]           
    vpcmpgtb ymm2, ymm0, [rel mask]
    vpmovmskb eax, ymm2 ; bit set on leading bytes
    mov ecx, 1 << 5            
    pdep ecx, ecx, eax  ; select only the 5° byte
    tzcnt ecx, ecx      ; check its idx

    vpcmpeqb ymm2, ymm0, ymm1       
    vpmovmskb edx, ymm2 ; bit set on NUL
    tzcnt edx, edx      ; check its idx

    cmp ecx, edx               
    cmova ecx, edx      ; get the lowest idx

    mov eax, -1               
    bzhi eax, eax, ecx  ; clear bits from idx on
    kmovd k3, eax
    vmovdqu8 [rdi]{k3}, ymm0 ; store only up to idx
    ret

%ifidn __OUTPUT_FORMAT__,elf64
section .note.GNU-stack noalloc noexec nowrite progbits
%endif
