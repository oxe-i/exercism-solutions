; This exercise is a good opportunity to explore on recursion using assembly
; However, in general, it is more efficient to use callee-saved registers to hold variables (saving them on the stack first)
; The use of arrays to represent the lists contributes to make a recursive approach cumbersome in some cases
; 
; Since in most tasks an external function is called (to filter, transform or reduce), the stack was kept 16-byte aligned


section .text
global append
append:
    xchg rdi, r8
    xchg rsi, r8
    xchg rcx, r8
    mov eax, ecx
    rep movsd

    mov rsi, rdx
    mov rcx, r8
    add eax, ecx
    rep movsd
    ret

global filter
filter:
    sub rsp, 56
    mov qword [rsp], rbx
    mov qword [rsp + 8], r12
    mov qword [rsp + 16], r13
    mov qword [rsp + 24], r14
    mov qword [rsp + 32], r15
    mov qword [rsp + 40], rbp

    xor ebx, ebx           ; counter
    mov r12, rdi           ; input array
    lea r13, [rdi + 4*rsi] ; end of input array
    mov r14, rdx           ; predicate
    mov r15, rcx           ; output buffer
.tail_helper:
    cmp r12, r13
    je .end

    mov edi, dword [r12]
    mov ebp, edi
    add r12, 4

    call r14

    mov dword [r15 + 4*rbx], ebp

    lea ecx, [ebx + 1]
    test eax, eax
    cmovnz ebx, ecx  

    jmp .tail_helper
.end:    
    mov eax, ebx

    mov rbp, qword [rsp + 40]
    mov r15, qword [rsp + 32]
    mov r14, qword [rsp + 24]
    mov r13, qword [rsp + 16]
    mov r12, qword [rsp + 8]
    mov rbx, qword [rsp]
    add rsp, 56
    ret

global map
map:
    sub rsp, 56    ; 8 more for stack alignment
    mov qword [rsp], rbx
    mov qword [rsp + 8], r12
    mov qword [rsp + 16], r13
    mov qword [rsp + 24], r14
    mov qword [rsp + 32], r15
    mov qword [rsp + 40], rbp

    xor ebx, ebx   ; counter
    mov r12, rdi   ; input array
    mov r13d, esi  ; size of input array
    mov r14, rdx   ; transform
    mov r15, rcx   ; output buffer
.tail_helper:
    cmp ebx, r13d
    je .end

    mov edi, dword [r12 + 4*rbx]
    mov ebp, edi

    call r14

    mov dword [r15 + 4*rbx], eax
    inc ebx

    jmp .tail_helper
.end:    
    mov eax, ebx

    mov rbp, qword [rsp + 40]
    mov r15, qword [rsp + 32]
    mov r14, qword [rsp + 24]
    mov r13, qword [rsp + 16]
    mov r12, qword [rsp + 8]
    mov rbx, qword [rsp]
    add rsp, 56
    ret

global foldl
foldl:
    ; tail-recursive solution, for fun =)

    test esi, esi
    jz .end       ; base case

    push rdi
    mov edi, dword [rdi]

    push rsi
    mov esi, edx

    push rcx
    call rcx      ; odd numbers of pushes, stack is aligned
    pop rcx

    mov edx, eax

    pop rsi
    dec rsi

    pop rdi
    add rdi, 4

    jmp foldl
.end:
    mov eax, edx
    ret

global foldr
foldr:
    sub rsp, 40    ; 8 more for stack alignment
    mov qword [rsp], rbx
    mov qword [rsp + 8], r12
    mov qword [rsp + 16], r13
    mov qword [rsp + 24], r14

    mov ebx, esi   ; num of elements
    mov r12, rdi   ; input array
    mov r13, rcx   ; transform function
    mov r14d, edx  ; initial value
.transform_loop:
    test ebx, ebx
    jz .end

    dec ebx
    mov edi, r14d
    mov esi, dword [r12 + 4*rbx]
    call r13
    mov r14d, eax
    jmp .transform_loop
.end:
    mov eax, r14d

    mov r14, qword [rsp + 24]
    mov r13, qword [rsp + 16]
    mov r12, qword [rsp + 8]
    mov rbx, qword [rsp]
    add rsp, 40
    ret

global reverse
reverse:
    xor eax, eax
.rev_loop:
    test esi, esi
    jz .end

    lea rsi, [esi - 1]
    mov ecx, dword [rdi + 4*rax]
    mov dword [rdx + 4*rsi], ecx
    inc eax
    jmp .rev_loop
.end:
    ret

%ifidn __OUTPUT_FORMAT__,elf64
section .note.GNU-stack noalloc noexec nowrite progbits
%endif
