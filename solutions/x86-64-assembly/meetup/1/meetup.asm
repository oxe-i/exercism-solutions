section .rodata
tbs: dd 0, 3, 2, 5, 0, 3, 5, 1, 4, 6, 2, 4
     dd 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31

section .text
global meetup

; contract:
; `rbx`, `r12` and `r13` as spare registers for macros
; the return value, if any, is on `rbx`

%macro is_leap 1
    xor ebx, ebx
    xor r13d, r13d
    
    test %1, 15
    setz bl
    
    imul r12d, %1, 0xFFFFFFFF / 25 + 1
    cmp r12d, 0xFFFFFFFF / 25
    setbe r13b    
    and bl, r13b
    
    test %1, 3
    setz r12b    
    andn r12d, r13d, r12d
    
    or bl, r12b
%endmacro

%macro stringify 3
    xor ebx, ebx
    mov eax, %1
    mov r12d, 0xFFFFFFFF / 10 + 1
    %rep %2
        mov r13d, eax
        mul r12d
        lea eax, [edx + edx]
        lea eax, [eax + 4*eax]
        sub r13d, eax
        shl ebx, 8
        lea ebx, [ebx + r13d + '0']
        mov eax, edx
    %endrep
    mov dword [rdi + %3], ebx
    mov byte [rdi + %2 + %3], '-'
%endmacro

meetup:
    ; the code uses Sakamoto's algorithm
    ; https://en.wikipedia.org/wiki/Determination_of_the_day_of_the_week
    
    push rbx
    push r12
    push r13
    push r14
    push r15

    lea r15, [rel tbs]
    mov r14d, edx 
   
    stringify esi, 4, 0
    stringify r14d, 2, 5

    lea r9d, [8*ecx]
    sub r9d, ecx     ; last   
    
    mov edx, 19
    cmp ecx, 5             
    cmovz r9d, edx   ; if TEENTH, last == 19

    is_leap esi

    xor edx, edx
    cmp r14d, 2
    setz dl
    and edx, ebx
    
    mov r11d, dword [r15 + 4*r14 + 44]
    add r11d, edx    ; number of days in month 

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
    imul eax, r10d, 0xFFFFFFFF / 7 + 1
    mov r11d, 7
    mul r11d
    ; edx now holds r10d % 7
    
    xor r11d, r11d
    cmp r8d, 7
    cmovz r8d, r11d
    
    sub edx, r8d
    lea r8d, [edx + 7]
    cmovl edx, r8d    
    sub r9d, edx
    
    stringify r9d, 2, 8
    mov byte [rdi + 10], 0

    pop r15
    pop r14
    pop r13
    pop r12
    pop rbx
    ret

%ifidn __OUTPUT_FORMAT__,elf64
section .note.GNU-stack noalloc noexec nowrite progbits
%endif
