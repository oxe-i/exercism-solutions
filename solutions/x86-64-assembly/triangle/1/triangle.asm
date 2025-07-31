default rel

section .rodata
    zero dq 0.0

section .text

%macro PROLOGUE 0
    push rbp
    mov rbp, rsp
%endmacro

%macro EPILOGUE 0
    pop rbp
    ret
%endmacro

%macro LOAD_VARIABLES 0
    movsd xmm0, [rbp + 16]
    movsd xmm1, [rbp + 24]
    movsd xmm2, [rbp + 32]
%endmacro

%macro CHECK_VALID_SIDE 1
    ucomisd %1, [zero]
    jbe false
%endmacro

%macro CHECK_TRIANGLE_INEQUALITY 3    
    movsd xmm3, %1
    addsd xmm3, %2
    ucomisd xmm3, %3
    jb false
%endmacro

%macro INITIAL_CHECKS 3
    CHECK_VALID_SIDE %1
    CHECK_VALID_SIDE %2
    CHECK_VALID_SIDE %3
    
    CHECK_TRIANGLE_INEQUALITY %1, %2, %3
    CHECK_TRIANGLE_INEQUALITY %2, %3, %1
    CHECK_TRIANGLE_INEQUALITY %1, %3, %2
%endmacro

global is_equilateral

false:
    mov rax, 0
    EPILOGUE

true:
    mov rax, 1
    EPILOGUE

is_equilateral:
    PROLOGUE
    
    LOAD_VARIABLES
    INITIAL_CHECKS xmm0, xmm1, xmm2
    
    ucomisd xmm0, xmm1
    jne false
    ucomisd xmm1, xmm2
    jne false
    
    jmp true

global is_isosceles
is_isosceles:
    PROLOGUE
    
    LOAD_VARIABLES
    INITIAL_CHECKS xmm0, xmm1, xmm2
    
    ucomisd xmm0, xmm1
    je true
    ucomisd xmm0, xmm2
    je true
    ucomisd xmm1, xmm2
    je true
    
    jmp false
    
global is_scalene
is_scalene:
    PROLOGUE
    
    LOAD_VARIABLES
    INITIAL_CHECKS xmm0, xmm1, xmm2
    
    ucomisd xmm0, xmm1
    je false
    ucomisd xmm0, xmm2
    je false
    ucomisd xmm1, xmm2
    je false
    
    jmp true

%ifidn __OUTPUT_FORMAT__,elf64
section .note.GNU-stack noalloc noexec nowrite progbits
%endif