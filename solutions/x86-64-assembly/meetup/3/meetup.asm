section .rodata
tbs: dd 0, 3, 2, 5, 0, 3, 5, 1, 4, 6, 2, 4
     dd 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31
%assign i 0
%rep 100
     db ('0' + i / 10), ('0' + i % 10)
%assign i i + 1
%endrep

db ((399 + 399/4 - 399/100) % 7)
%assign i 0
%rep 400
     db ((i + i/4 - i/100) % 7)
%assign i i + 1
%endrep

%assign i 0
%rep 43
     db i % 7
%assign i i + 1
%endrep

section .text
global meetup

meetup:
    ; the code uses Sakamoto's algorithm
    ; https://en.wikipedia.org/wiki/Determination_of_the_day_of_the_week
    
    lea r11, [rel tbs]
    mov r10d, edx

    mov edx, 0xFFFFFFFF / 100 + 1
    mov eax, esi
    mul edx

    movzx r9d, word [r11 + 96 + 2*rdx]
    mov dword [rdi], r9d

    imul eax, edx, 100
    sub esi, eax
    setne al  ; y % 100 != 0

    movzx r9d, word [r11 + 96 + 2*rsi]
    or r9d, ('-' << 16)
    mov dword [rdi + 2], r9d
    
    and edx, 3
    setz r9b  ; y % 400 == 0
    or al, r9b

    test esi, 3
    setz r9b
    and r9b, al
    
    imul edx, edx, 100
    add edx, esi

    cmp r10d, 3
    sbb rdx, 0
    movzx eax, byte [r11 + 297 + rdx]
    add eax, dword [r11 + 4*r10 - 4]
    
    movzx esi, word [r11 + 96 + 2*r10]
    or esi, ('-' << 16)
    mov dword [rdi + 5], esi

    xor edx, edx
    cmp r10d, 2
    setz dl
    and dl, r9b
    add edx, dword [r11 + 4*r10 + 44]
    
    lea r9d, [ecx*8]
    sub r9d, ecx    ; 7 * week
    mov esi, 19
    cmp ecx, 5
    cmovz r9d, esi ; TEENTH
    cmp ecx, 6
    cmovz r9d, edx  ; LAST
    
    add eax, r9d
    sub eax, r8d
    movzx eax, byte [r11 + 697 + rax]
    sub r9d, eax

    movzx edx, word [r11 + 96 + 2*r9]
    mov dword [rdi + 8], edx ; includes NUL
    
    ret
    
%ifidn __OUTPUT_FORMAT__,elf64
section .note.GNU-stack noalloc noexec nowrite progbits
%endif
