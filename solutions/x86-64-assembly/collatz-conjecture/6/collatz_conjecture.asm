section .text
global steps
steps:
    xor eax, eax
    
    cmp edi, 1
    jl .error
    je .exit
    
    test edi, 1
    jz .even
.loop:
    lea edi, [edi + 2*edi]
    inc edi
    inc eax
.even:
    tzcnt edx, edi
    add eax, edx
    shrx edi, edi, edx
    cmp edi, 1
    jnz .loop
.exit:
    ret
    
.error:
    mov eax, -1
    ret

%ifidn __OUTPUT_FORMAT__,elf64
section .note.GNU-stack noalloc noexec nowrite progbits
%endif
