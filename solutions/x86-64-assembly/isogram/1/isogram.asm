section .text

%macro TEST_AND_SET 1
    sub cl, %1
    bts r8, rcx
    jc end
    jmp loop 
%endmacro

is_upper:
    xor r10, r10
    cmp cl, 'A'
    jl is_upper_end
    cmp cl, 'Z'
    jg is_upper_end
    mov r10b, 1
is_upper_end:
    ret
    
is_lower:
    xor r10, r10
    cmp cl, 'a'
    jl is_lower_end
    cmp cl, 'z'
    jg is_lower_end
    mov r10b, 1
is_lower_end:
    ret
    
global is_isogram
is_isogram:
    xor r8, r8 ; bitmap
    xor rax, rax ; result
    xor r9, r9 ; counter
loop:
    xor rcx, rcx ; current letter
    mov cl, byte [rdi + r9]
    add r9, 1
    
    cmp cl, 0
    je true
    
    call is_upper ; saves boolean in r10b

    cmp r10b, 1
    je handle_upper

    call is_lower ; saves boolean in r10b

    cmp r10b, 1
    jne loop

    TEST_AND_SET 'a'
handle_upper:
    TEST_AND_SET 'A'
true:
    mov rax, 1
end:
    ret

%ifidn __OUTPUT_FORMAT__,elf64
section .note.GNU-stack noalloc noexec nowrite progbits
%endif
