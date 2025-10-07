section .rodata
    outer_radius dq 100.0
    mid_radius dq 25.0
    inner_radius dq 1.0

section .text
global score
score:
    xor rax, rax
    mulsd xmm0, xmm0
    mulsd xmm1, xmm1
    addsd xmm0, xmm1    
    ucomisd xmm0, qword [rel outer_radius]
    ja outside
    ucomisd xmm0, qword [rel mid_radius]
    ja outer
    ucomisd xmm0, qword [rel inner_radius]
    ja middle
    add rax, 5
middle:
    add rax, 4
outer:
    add rax, 1
outside:
    ret

%ifidn __OUTPUT_FORMAT__,elf64
section .note.GNU-stack noalloc noexec nowrite progbits
%endif
