section .text

check_triangle:
    xor eax, eax
    
    vmovq xmm1, [rsp + 8]
    vmovq xmm2, [rsp + 16]
    vmovq xmm3, [rsp + 24]

    vmaxsd xmm5, xmm1, xmm2
    vminsd xmm4, xmm1, xmm2
    vmaxsd xmm6, xmm5, xmm3
    vminsd xmm5, xmm5, xmm3
    vmaxsd xmm5, xmm5, xmm4
    vminsd xmm4, xmm4, xmm3

    vaddsd xmm7, xmm4, xmm5
    vpxor xmm0, xmm0

    vucomisd xmm4, xmm0
    jbe .done
    
    vucomisd xmm7, xmm6
    jb .done

    jmp rdi
.done:
    ret
    
global is_equilateral
is_equilateral:  
    lea rdi, [rel is_equilateral.lambda]
    jmp check_triangle
    
.lambda:
    vucomisd xmm4, xmm6
    sete al
    ret

global is_isosceles
is_isosceles:
    lea rdi, [rel is_isosceles.lambda]
    jmp check_triangle
    
.lambda:
    vucomisd xmm4, xmm5
    sete al
    vucomisd xmm5, xmm6
    sete cl
    or al, cl
    ret

global is_scalene
is_scalene:
    lea rdi, [rel is_scalene.lambda]
    jmp check_triangle

.lambda:
    vucomisd xmm4, xmm5
    setne al
    vucomisd xmm5, xmm6
    setne cl
    and al, cl
    ret

%ifidn __OUTPUT_FORMAT__,elf64
section .note.GNU-stack noalloc noexec nowrite progbits
%endif
