section .text
global steps
steps:
    mov eax, -1
    test edi, edi
    jle .done

    xor eax, eax
    cmp edi, 1
    je .done    
.loop:
    lea edx, [edi + 2*edi + 1]
    lea ecx, [eax + 1]
    test edi, 1
    cmovnz edi, edx
    cmovnz eax, ecx
    tzcnt edx, edi
    add eax, edx
    shrx edi, edi, edx
    cmp edi, 1
    jne .loop
.done:
    ret

%ifidn __OUTPUT_FORMAT__,elf64
section .note.GNU-stack noalloc noexec nowrite progbits
%endif
