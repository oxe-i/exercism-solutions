section .text
global encode, decode

%macro rotate_alpha 0
    mov dl, 'z'
    add dl, 'a'
    sub dl, al
    xchg dl, al
%endmacro

%macro transform 0-1
    xor rcx, rcx
%%loop:
    lodsb

    cmp al, 'a'
    setge r8b
    cmp al, 'z'
    setle r9b
    and r8b, r9b
    jnz %%handle_lower

    cmp al, 'A'
    setge r8b
    cmp al, 'Z'
    setle r9b
    and r8b, r9b
    jnz %%handle_upper

    cmp al, '0'
    setge r8b
    cmp al, '9'
    setle r9b
    and r8b, r9b
    jnz %%handle_digit

    cmp al, 0
    jne %%loop
    
    mov al, 0
    stosb
    ret
%%handle_upper:
    add al, 32
%%handle_lower:
    rotate_alpha
%%handle_digit:
    %if %0 != 0
       cmp rcx, 5
       je %%add_space
       inc rcx
       stosb
    %else
       stosb
    %endif
    jmp %%loop
%%add_space:
    xor rcx, rcx
    mov dl, ' '
    xchg al, dl
    stosb
    xchg al, dl
    stosb
    inc rcx
    jmp %%loop
%endmacro

encode:
    transform 1
    ret

decode:
    transform
    ret

%ifidn __OUTPUT_FORMAT__,elf64
section .note.GNU-stack noalloc noexec nowrite progbits
%endif
