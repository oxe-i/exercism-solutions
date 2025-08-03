section .text

is_lower:
    cmp al, 'a'
    jl false
    cmp al, 'z'
    jg false
    jmp true

is_upper:
    cmp al, 'A'
    jl false
    cmp al, 'Z'
    jg false
    jmp true

true:
    mov r10, 1
    ret

false:
    xor r10, r10
    ret
  
global abbreviate
abbreviate:
    ; Provide your implementation here
    ; rdi - char * in - read
    ; rsi - char * out - write result, assume length 0x100

    xchg rdi, rsi
    mov rdx, 1; flag for separator
loop:
    lodsb
    cmp al, ' '
    sete r8b
    cmp al, '-'
    sete r9b
    or r8b, r9b
    or dl, r8b
    call is_upper
    and r10b, dl
    test r10, r10
    jnz handle_upper
    call is_lower
    and r10b, dl
    test r10, r10
    jnz handle_lower
    test al, al
    jnz loop
 
    ret
handle_lower:
    sub al, 32
handle_upper:
    stosb
    xor dl, dl
    jmp loop

%ifidn __OUTPUT_FORMAT__,elf64
section .note.GNU-stack noalloc noexec nowrite progbits
%endif