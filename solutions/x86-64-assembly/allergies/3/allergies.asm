section .text
global allergic_to
allergic_to:
    xor eax, eax
    bt esi, edi
    setc al
    ret

global list
list:
    mov dword [rsi], 0
    and edi, 0xFF
.repeat:
    tzcnt ecx, edi
    jc .exit
    mov eax, dword [rsi]
    mov dword [rsi + 4 + 4*rax], ecx
    btr edi, ecx
    inc dword [rsi]
    jmp .repeat
.exit:    
    ret

%ifidn __OUTPUT_FORMAT__,elf64
section .note.GNU-stack noalloc noexec nowrite progbits
%endif
