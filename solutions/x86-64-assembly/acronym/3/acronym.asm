section .text
global abbreviate
abbreviate:
    mov eax, 1          ; flag for word start. Default is TRUE
    mov ecx, 1          ; for using CMOV
.repeat:
    mov dl, byte [rdi]
    test dl, dl
    jz .exit            ; end of string

    inc rdi

    cmp dl, '-'
    cmove eax, ecx      ; word separator, set flag to TRUE

    cmp dl, ' '
    cmove eax, ecx      ; word separator, set flag to TRUE

    or dl, 32           ; to lower
    xor dl, 32          ; to upper
    
    mov r8b, dl
    sub r8b, 'A'
    cmp r8b, 26
    setb r9b            ; if upper(char) - 'A' < 26, it is letter

    and r9b, al         
    jz .repeat          ; if !(letter and flag), continue
    ; otherwise, store letter

    xor al, al          ; reset flag
    mov byte [rsi], dl  ; store letter
    inc rsi             
    jmp .repeat         ; continue
.exit:
    mov byte [rsi], 0   ; store NUL
    ret

%ifidn __OUTPUT_FORMAT__,elf64
section .note.GNU-stack noalloc noexec nowrite progbits
%endif
