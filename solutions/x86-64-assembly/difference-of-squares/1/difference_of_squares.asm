section .text

%macro SQUARE 1          
    imul %1, %1
%endmacro

global square_of_sum
global sum_of_squares
global difference_of_squares

sum_loop:
    add ecx, 1
    add eax, ecx
    cmp ecx, edi
    jl sum_loop
    ret

square_of_sum:
    mov eax, 0
    mov ecx, 0
    call sum_loop
    SQUARE eax
    ret

square_loop:
    add ecx, 1
    mov ebx, ecx
    SQUARE ebx
    add eax, ebx
    cmp ecx, edi
    jl square_loop    
    ret

sum_of_squares:
    mov eax, 0
    mov ecx, 0
    call square_loop
    ret
    
difference_of_squares:
    call sum_of_squares
    mov ebx, eax
    call square_of_sum
    sub eax, ebx
    ret

%ifidn __OUTPUT_FORMAT__,elf64
section .note.GNU-stack noalloc noexec nowrite progbits
%endif
