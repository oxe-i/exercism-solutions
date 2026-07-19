section .rodata
cross: db "X"
naught: db "O"

%macro check_win 4
    mov %2, %1
    and %2, %4
    cmp %2, %4
    setz al
    or %3, eax
%endmacro

%macro check_pos 1
    check_win ecx, r8d, r10d, %1
    check_win edx, r9d, r11d, %1
%endmacro

section .text
global gamestate
gamestate:
    mov r8, [rdi]
    mov r9, [rdi + 8]
    mov r10, [rdi + 16]

    vmovd xmm0, [r8]
    vpinsrd xmm0, [r9], 1
    vpinsrd xmm0, [r10], 2

    vpbroadcastb xmm1, [rel cross]
    vpbroadcastb xmm2, [rel naught]
    
    vpcmpeqb xmm3, xmm1, xmm0
    vpcmpeqb xmm4, xmm2, xmm0

    vpmovmskb ecx, xmm3
    vpmovmskb edx, xmm4

    xor eax, eax
    xor r10d, r10d ; cross win
    xor r11d, r11d ; naught win
    
    check_pos 0x007
    check_pos 0x070
    check_pos 0x700
    check_pos 0x111
    check_pos 0x222
    check_pos 0x444
    check_pos 0x421
    check_pos 0x124

    popcnt r8d, ecx
    popcnt r9d, edx

    mov eax, r8d
    sub eax, r9d
    cmp eax, 1
    ja .invalid    ; abs(x - o) > 1
    setz cl        ; x - o == 1
    setb dl        ; x - o == 0

    and dl, r10b   ; x won, o can't play
    and cl, r11b   ; o won, x can't play
    or dl, cl
    jnz .invalid

    xor eax, eax    ; ongoing == 0
    
    add r8d, r9d
    cmp r8d, 9
    sete al         ; draw == 1
    
    or  r10d, r11d   
    mov edx, 2      ; win == 2
    cmovnz eax, edx   
    
    ret

.invalid:
    mov eax, 3
    ret

%ifidn __OUTPUT_FORMAT__,elf64
section .note.GNU-stack noalloc noexec nowrite progbits
%endif
