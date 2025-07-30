section .text

global steps

steps:
    cmp edi, 0
    je .invalid
    js .invalid
    mov ecx, 0
    jmp .loop   

.invalid:
    mov eax, -1
    ret

.handleOdd:
    mov eax, edi
    imul eax, 3
    add eax, 1
    mov edi, eax
    jmp .loop

.handleEven:
    mov edi, eax
    jmp .loop

.loop:
    cmp edi, 1
    je end
    add ecx, 1
    mov eax, edi
    mov ebx, 2
    xor edx, edx
    div ebx
    cmp edx, 0
    je .handleEven
    jmp .handleOdd    
    
end:
    mov eax, ecx
    ret

%ifidn __OUTPUT_FORMAT__,elf64
section .note.GNU-stack noalloc noexec nowrite progbits
%endif
