section .text
global square_of_sum
square_of_sum:
    mov eax, edi
    mul edi
    add eax, edi
    shr eax, 1
    mul eax
    ret

global sum_of_squares
sum_of_squares:
    mov eax, edi
    mul edi
    add eax, edi
    lea edx, [edi + edi + 1]
    mul edx
    mov rdx, (-1 / 6) + 1
    mul rdx
    mov eax, edx
    ret

global difference_of_squares
difference_of_squares:
    mov eax, edi
    mul edi
    add eax, edi
    lea edi, [edi + edi + 1]
    shl edi, 2
    lea edx, [eax + 4*eax]
    lea edx, [edx + eax]
    sub edx, edi
    mul edx
    mov rdi, (-1 / 24) + 1
    mul rdi
    mov eax, edx
    ret

%ifidn __OUTPUT_FORMAT__,elf64
section .note.GNU-stack noalloc noexec nowrite progbits
%endif
