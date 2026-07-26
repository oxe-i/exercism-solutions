section .rodata
ascii:
%assign i 0
%rep 256
  %if (i >= 'A') && (i <= 'Z')
    dd 1 << (i - 'A')
  %elif (i >= 'a') && (i <= 'z')
    dd 1 << (i - 'a')
  %else
    dd 0
  %endif
  %assign i i + 1
%endrep

section .text
global is_isogram
is_isogram:
    lea r8, [rel ascii]
    xor edx, edx
    xor eax, eax
.loop:
    movzx esi, byte [rdi]
    inc rdi
    mov ecx, dword [r8 + 4 * rsi]
    test edx, ecx
    jnz .done
    or edx, ecx
    test esi, esi
    jnz .loop
    mov eax, 1
.done:
    ret

%ifidn __OUTPUT_FORMAT__,elf64
section .note.GNU-stack noalloc noexec nowrite progbits
%endif
