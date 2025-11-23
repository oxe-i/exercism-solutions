section .text
global is_isogram
is_isogram:
    mov rsi, rdi
    xor eax, eax
    xor edx, edx   ; bit map for letters
.loop:
    lodsb          ; crt letter in al
    
    test al, al
    jz .exit       ; reached end, return true
    
    lea edi, [eax - 65]
    btr edi, 5     ; to upper
    cmp edi, 26
    jae .loop      ; 65 <= upper < 65 + 26
    
    bts edx, edi   ; tests and sets bit
    jnc .loop      ; if no duplicate, continue
    
    setc al        ; if duplicate, set al
.exit:
    btc eax, 0     ; flips bit 0
    ret

%ifidn __OUTPUT_FORMAT__,elf64
section .note.GNU-stack noalloc noexec nowrite progbits
%endif
