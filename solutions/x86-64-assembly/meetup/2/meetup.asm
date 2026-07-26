section .rodata
tbs: dd 0, 3, 2, 5, 0, 3, 5, 1, 4, 6, 2, 4
     dd 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31
%assign i 0
%rep 100
     db ('0' + i / 10), ('0' + i % 10)
%assign i i + 1
%endrep

section .text
global meetup

meetup:
    ; the code uses Sakamoto's algorithm
    ; https://en.wikipedia.org/wiki/Determination_of_the_day_of_the_week
    
    push r14
    push r15

    lea r15, [rel tbs]
    mov r14d, edx 

    mov edx, 0xFFFFFFFF / 100 + 1
    mov eax, esi
    mul edx

    test edx, 3
    setz r10b    ; y % 400 == 0
    
    movzx r9d, word [r15 + 96 + 2*rdx]
    mov dword [rdi], r9d
    
    lea eax, [edx + 4*edx]
    lea eax, [eax + 4*eax]
    shl eax, 2
    mov edx, esi
    sub edx, eax

    movzx r9d, word [r15 + 96 + 2*rdx]
    or r9d, ('-' << 16)
    mov dword [rdi + 2], r9d

    cmp esi, eax
    setne r9b    ; y % 100 != 0
    
    or r9b, r10b 
    
    test esi, 3
    setz r10b    ; y % 4 == 0
    
    and r10b, r9b
    
    movzx edx, word [r15 + 96 + 2*r14]
    or edx, ('-' << 16)
    mov dword [rdi + 5], edx

    xor edx, edx
    cmp r14d, 2
    setz dl
    and dl, r10b
    
    mov r11d, dword [r15 + 4*r14 + 44]
    add r11d, edx    ; number of days in month 

    lea r9d, [8*ecx]
    sub r9d, ecx     ; last   
    
    mov edx, 19
    cmp ecx, 5             
    cmovz r9d, edx   ; if TEENTH, last == 19
    
    cmp ecx, 6
    cmovz r9d, r11d  ; if LAST, last == last day of month

    mov r10d, dword [r15 + 4*r14 - 4]
    
    cmp r14d, 3
    sbb esi, 0    ; y -= (m < 3)
    add r10d, esi ; y + tb
    
    mov eax, esi
    mov edx, 0xFFFFFFFF / 100 + 1
    mul edx       ; y / 100
    sub r10d, edx
    
    shr esi, 2    ; y / 4
    add r10d, esi

    shr edx, 2    ; y / 400
    add r10d, edx

    add r10d, r9d
    sub r10d, r8d
    imul eax, r10d, 0xFFFFFFFF / 7 + 1
    mov r11d, 7
    mul r11d
    sub r9d, edx

    movzx edx, word [r15 + 96 + 2*r9]
    mov dword [rdi + 8], edx

    pop r15
    pop r14
    ret

%ifidn __OUTPUT_FORMAT__,elf64
section .note.GNU-stack noalloc noexec nowrite progbits
%endif
