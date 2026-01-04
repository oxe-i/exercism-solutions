section .text
global clean
clean:
    xor ecx, ecx  ; counter for num of digits
    sub rsp, 12   ; buffer for digits
.count:
    lodsb
    mov byte [rsp + rcx], al ; keeps storing al at same pos until num digits increase
    sub al, '0'    ; to digit
    cmp al, 10     ; sets CF if al < 10 (unsigned)
    adc ecx, 0     ; ecx = ecx + (CF == 1)
    cmp ecx, 12
    je .exit       ; if num digits > 11, invalid
    cmp al, -1 * '0'
    jnz .count     ; continues until *rsi == \0

    xor edx, edx   ; start of NANP number on stack
    sub ecx, 10
    cmp ecx, 1
    ja .exit       ; if num digits < 10 or > 11, invalid
    sete r8b       ; sets if num digits == 11, clears otherwise

    cmp byte [rsp], '1'
    setne r9b      ; sets if first digit is 1, clears otherwise

    test r8b, r9b
    jnz .exit      ; if num digits == 11 and first digit != 1, invalid

    add dl, r8b    ; if num digits == 11, NANP starts at index 1 on stack

    movzx ecx, byte [rsp + rdx]
    cmp ecx, '2'
    jb .exit      ; if first digit in NANP number < 2, invalid

    movzx ecx, byte [rsp + rdx + 3]
    cmp ecx, '2'
    jb .exit      ; if fourth digit in NANP number < 2, invalid
    ; otherwise, NANP number is valid and should be stored

    lea rsi, [rsp + rdx]
    mov ecx, 10 ; NANP number is 10 digits long
    rep movsb
.exit:
    mov byte [rdi], 0 ; adds NUL at the end
    add rsp, 12       ; restores stack
    ret

%ifidn __OUTPUT_FORMAT__,elf64
section .note.GNU-stack noalloc noexec nowrite progbits
%endif
