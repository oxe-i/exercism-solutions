%include "debug.mac"

section .text
global square_of_sum
square_of_sum:
    lea eax, [edi + 1]
    mul edi
    mul eax
    shr eax, 2
    ret

global sum_of_squares
sum_of_squares:
    lea rax, [edi + 1]
    lea edx, [eax + edi]
    mul edx
    mul edi
    mov rdx, (-1 / 6) + 1
    mul rdx
    mov eax, edx
    ret

global difference_of_squares
difference_of_squares:
    lea rax, [edi + 1]     ; n + 1
    lea ecx, [eax + edi]   ; 2 * (n + 1)
    mul edi
    mov edx, eax           ; n * (n + 1)
    lea eax, [eax + 2*eax] ; 3 * (n * (n + 1))
    shl eax, 1             ; 6 * (n * (n + 1))
    not ecx                ; neg(x) == not(x) + 1
    lea rax, [eax + 4*ecx + 4] ; eax - 4 * ecx
    mul edx                
    mov rdx, (-1 / 24) + 1
    mul rdx
    mov eax, edx
    ret

%ifidn __OUTPUT_FORMAT__,elf64
section .note.GNU-stack noalloc noexec nowrite progbits
%endif
