section .text
global prime

prime:
    ; rdi - number as a uint64_t
    ; return is an int64_t in rax

    bsr r10, rdi
    mov rax, -1
    jz .done ; rdi == 0

    bsr r11, r10
    mov eax, 2
    jz .done ; r10 == 0 -> rdi == 1

    ; we have already accounted for `2`
    ; all other primes are odd, so of the form `2*i + 1`
    ; so, instead of tracking the number, we can track `i`
    ; this makes the search twice as fast, and reduce memory usage by half 

    lea r10d, [r10d + r11d + 1]
    imul r10, rdi
    shr r10, 1
    mov r9, r10 ; upper bound for `i`

    and r10, -32
    add r10, 32 

    mov rsi, rsp
    sub rsp, r10
    and rsp, -32

    vpcmpeqb ymm1, ymm1, ymm1 ; all 0xFF
    mov rcx, r10
.start:
    sub rcx, 32
    vmovdqa [rsp + rcx], ymm1
    jnz .start
    
    xor r11d, r11d ; i
    mov ecx, 1     ; prime count, starts as 1 because 2 is prime
.find:    
    sub r11, 31
.find_loop:
    add r11, 32
    vmovdqu ymm2, [rsp + r11]
    vpmovmskb edx, ymm2 ; lanes are already 0 or 0xFF, we don't need pcmpeqb
    test edx, edx
    jz .find_loop
    
    tzcnt edx, edx
    add r11, rdx  ; i of the current prime
    inc rcx             

    lea rax, [r11 + r11 + 1] ; the prime `p` is 2i + 1

    ; first composite is `p` * `p` == 4i² + 4i + 1
    ; this corresponds to a j equal to 2i² + 2i : 4i² + 4i + 1 == 2 * (2i² + 2i) + 1

    ; each composite after `x` is equal to `x` + `p`
    ; if `x` == 2j + 1, then `x` + `p` == 2j + 1 + 2i + 1 == 2*(j + i + 1)
    ; this is even, so we have already excluded it
    ; the next one is `x` + 2`p` == 2j + 1 + 4i + 2 == 2*(j + 2i + 1) + 1
    ; that means the stride from `j` to the next index is `2i + 1`, exactly `p`
    
    mov r8, r11
    imul r8, r8  
    add r8, r11
    shl r8, 1    ; i == 2i² + 2i
    
    cmp r8, r9
    jae .after   ; above sieve limit
.clear:
    mov byte [rsp + r8], 0
    add r8, rax  ; stride == `p`
    cmp r8, r9
    jb .clear
.after:
    cmp rcx, rdi
    jb .find     ; repeat until count == n

    mov rsp, rsi
    vzeroupper
.done:
    ret

%ifidn __OUTPUT_FORMAT__,elf64
section .note.GNU-stack noalloc noexec nowrite progbits
%endif

