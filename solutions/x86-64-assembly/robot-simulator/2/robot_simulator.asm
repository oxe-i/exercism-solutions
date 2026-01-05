section .text

global create
global move

create:
    ; edi - int32_t representing x coordinate
    ; esi - int32_t representing y coordinate
    ; edx - int32_t representing direction
    ; return is a struct of 3 int32_t

    ; Given that the return is formed of 3 int32_t
    ; the first two are passed in rax,
    ; being the first in the lower 32 bits
    ; and the second in the upper 32 bits
    ; the third is passed in rdx
    ; where it's already when the function is called

    mov eax, edi
    shl rsi, 32
    or rax, rsi
    
    ret

move:
    ; rdi - pointer to robot
    ; rsi - input string
    ; return is void

    lodsb

    mov edx, dword [rdi + 8]
    lea r8d, [edx - 1]
    lea ecx, [edx + 1]
  
    cmp al, 'L'
    cmove edx, r8d
    cmova edx, ecx

    and edx, 3
    mov dword [rdi + 8], edx

    mov r8d, 1
    mov r9d, -1

    cmp edx, 1
    cmova r8d, r9d

    xor r9d, r9d
    xor r10d, r10d
    test edx, 1
    cmovz r9d, r8d
    cmovz r8d, r10d

    mov ecx, dword [rdi]
    mov edx, dword [rdi + 4]
    add r8d, ecx
    add r9d, edx
    
    cmp al, 'A'
    cmove ecx, r8d
    cmove edx, r9d

    mov dword [rdi], ecx
    mov dword [rdi + 4], edx

    test al, al
    jnz move
    
    ret

%ifidn __OUTPUT_FORMAT__,elf64
section .note.GNU-stack noalloc noexec nowrite progbits
%endif
