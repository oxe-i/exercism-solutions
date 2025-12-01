section .text
global square_of_sum
square_of_sum:
    mov eax, edi
    imul eax, edi
    add eax, edi
    shr eax, 1
    imul eax, eax
    ret

global sum_of_squares
sum_of_squares:
    lea ecx, [edi + edi + 1]
    mov eax, edi
    imul eax, edi
    add eax, edi
    imul eax, ecx
    mov rdi, (-1 / 6) + 1
    mul rdi
    mov eax, edx
    ret

global difference_of_squares
difference_of_squares:
    mov eax, edi
    imul eax, edi
    add eax, edi             ; n² + n
    lea edi, [edi + edi + 1] ; 2n + 1
    shl edi, 2               ; 4 * (2n + 1)
    imul ecx, eax, 6
    sub ecx, edi             ; 6 * (n² + n) - 4 * (2n + 1)
    imul eax, ecx            ; (n² + n) * (6 * (n² + n) - 4 * (2n + 1))
    mov rdi, (-1 / 24) + 1
    mul rdi
    mov eax, edx
    ret

%ifidn __OUTPUT_FORMAT__,elf64
section .note.GNU-stack noalloc noexec nowrite progbits
%endif
