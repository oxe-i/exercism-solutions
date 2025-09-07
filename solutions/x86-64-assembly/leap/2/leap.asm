section .text

global leap_year
leap_year:
    ; an example of branchless code
    
    mov esi, edi
    
    and edi, 3
    setz r8b ; divisible by 4
    
    mov eax, esi
    xor rdx, rdx
    mov r10d, 100
    div r10d
    
    cmp rdx, 0
    setne r9b ; non divisible by 100

    mov eax, esi
    xor rdx, rdx
    mov r10d, 400
    div r10d
    
    cmp rdx, 0
    sete r10b ; divisible by 400

    and r8b, r9b ; divisible by 4 and
                 ; non divisible by 100
                 
    or r8b, r10b ; divisible by 400 or
                 ; (divisible by 4 and
                 ; non divisible by 100)
                 
    xor eax, eax
    mov al, r8b
    ret
    
    

%ifidn __OUTPUT_FORMAT__,elf64
section .note.GNU-stack noalloc noexec nowrite progbits
%endif
