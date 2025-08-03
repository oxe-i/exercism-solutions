default rel

section .bss
    digits resd 10

section .text
global is_armstrong_number
is_armstrong_number:
    ; edi - number
    ; output is a boolean in eax

    mov eax, edi
    xor rcx, rcx ; num of digits
    mov r10, 10
    lea r11, [digits]
main_loop:
    xor rdx, rdx
    div r10d
    mov dword [r11 + 4*rcx], edx
    inc rcx
    cmp eax, 0
    jne main_loop

    xor r10, r10 ; accumulator
    xor rsi, rsi ; current digit
    mov r8, rcx ; exponent
accumulate:
    mov esi, dword [r11 + 4*rcx - 4]
    mov r9, r8
    mov rax, 1
pow:
    mul esi
    dec r9
    cmp r9, 0
    jne pow

    add r10d, eax
    loop accumulate
end:
    xor rax, rax
    cmp edi, r10d
    sete al
    ret

%ifidn __OUTPUT_FORMAT__,elf64
section .note.GNU-stack noalloc noexec nowrite progbits
%endif
