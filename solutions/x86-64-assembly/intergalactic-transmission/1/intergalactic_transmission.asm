WRONG_PARITY equ -1

section .text
global transmit_sequence, decode_message

; TODO: add comments

%macro check_parity 0
    xor r9, r9
    btr rax, 0
    adc r9, 0

    popcnt r10, rax
    and r10b, 1
    add r10, r9
    and r10b, 1
    jnz bad_parity
%endmacro

transmit_sequence:
    ; rdi - uint8_t buffer
    ; rsi - message in uint8_t array
    ; edx - message length
    ; output is size of the buffer in eax

    xor r8, r8
    push r12
    push r13
    xor r12, r12
    xor r13, r13

    cmp edx, 0
    je end_encode
    mov rcx, 1
    xor rax, rax    
encode_loop:
    cmp r13d, edx
    jge end_encode_loop

    cmp rcx, 8
    je erase_carry

    lodsb
    inc r13
    
    mov r10b, 255 
    shr r10b, cl ; mask to get bits to be added to previously stored ones
    
    mov r11b, r10b
    not r11b ; mask to get bits to store for next iteration

    ror al, cl ; rotate to the right, so the bits to be stored for next iteration are on the most significant positions
    mov r9b, al ; copy
    and al, r10b ; apply first mask
    and r9b, r11b ; apply second mask
    shl al, 1 
    or al, r8b

    popcnt r10, rax ; get count of bits
    and r10b, 1 ; check parity
    or al, r10b ; if odd, set first bit

    stosb
    inc r12

    mov r8b, r9b
    inc rcx
    jmp encode_loop
erase_carry:
    mov al, r8b
    btr rax, 0
    sete r8b
    shr r8b, 7

    popcnt r10, rax
    and r10b, 1
    or al, r10b

    stosb
    inc r12

    mov rcx, 1
    jmp encode_loop
end_encode_loop:
    mov al, r8b

    popcnt r10, rax
    and r10b, 1
    or al, r10b

    stosb
    inc r12
end_encode:
    mov rax, r12
    pop r13
    pop r12
    ret

decode_message:
    ; rdi - uint8_t buffer
    ; rsi - message in uint8_t array
    ; edx - message length
    ; output is size of the buffer in eax

    xor r8, r8
    push r12
    push r13
    xor r12, r12
    xor r13, r13
    xor rax, rax

    cmp edx, 0
    je end_encode

erase_decode_carry:
    lodsb

    check_parity

    mov r8b, al
    inc r13d
    mov rcx, 1
decode_loop:
    cmp r13d, edx
    jge end_decode_loop

    cmp rcx, 8
    je erase_decode_carry

    lodsb
    inc r13

    check_parity

    mov r10b, 255
    shl r10b, cl

    mov r11b, r10b
    not r11b

    rol al, cl
    mov r9b, al
    and al, r11b
    and r9b, r10b
    or al, r8b

    stosb
    inc r12

    mov r8b, r9b

    inc rcx
    jmp decode_loop
end_decode_loop:
    cmp r8b, 0
    je end_decode

    mov al, r8b
    stosb
    inc r12
end_decode:
    mov rax, r12
    pop r13
    pop r12
    ret
bad_parity:
    mov rax, -1
    pop r13
    pop r12
    ret


%ifidn __OUTPUT_FORMAT__,elf64
section .note.GNU-stack noalloc noexec nowrite progbits
%endif
