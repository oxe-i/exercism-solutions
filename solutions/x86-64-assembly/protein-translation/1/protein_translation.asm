default rel

section .rodata
    codon1 db "AUG", 0
    codon2 db "UUU", 0
    codon3 db "UUC", 0
    codon4 db "UUA", 0
    codon5 db "UUG", 0
    codon6 db "UCU", 0
    codon7 db "UCC", 0
    codon8 db "UCA", 0
    codon9 db "UCG", 0
    codon10 db "UAU", 0
    codon11 db "UAC", 0
    codon12 db "UGU", 0
    codon13 db "UGC", 0
    codon14 db "UGG", 0
    codon15 db "UAA", 0
    codon16 db "UAG", 0
    codon17 db "UGA", 0
    amino1 db "Methionine", 0
    amino2 db "Phenylalanine", 0
    amino3 db "Leucine", 0
    amino4 db "Serine", 0
    amino5 db "Tyrosine", 0
    amino6 db "Cysteine", 0
    amino7 db "Tryptophan", 0
    stop db "STOP", 0

section .bss
    codons resq 18
    aminoacids resq 18
    current_codon resb 3
    data_set resb 1

section .text

find_codon:
    push rdi
    push rsi
    lea rdx, [codons]
    mov rax, -1
find_codon_main_loop:
    lea rsi, [current_codon]
    inc rax
    cmp rax, 17
    je find_codon_end
    mov rdi, [rdx + 8*rax]
    mov rcx, 3
    repe cmpsb
    jne find_codon_main_loop
find_codon_end:
    mov rcx, rax
    pop rsi
    pop rdi
    ret

fill_codons:
    push rdi
    push rsi

    lea rdi, [codons]
    lea rsi, [codon1]
    mov qword [rdi], rsi
    lea rsi, [codon2]
    mov qword [rdi + 8], rsi
    lea rsi, [codon3]
    mov qword [rdi + 16], rsi
    lea rsi, [codon4]
    mov qword [rdi + 24], rsi
    lea rsi, [codon5]
    mov qword [rdi + 32], rsi
    lea rsi, [codon6]
    mov qword [rdi + 40], rsi
    lea rsi, [codon7]
    mov qword [rdi + 48], rsi
    lea rsi, [codon8]
    mov qword [rdi + 56], rsi
    lea rsi, [codon9]
    mov qword [rdi + 64], rsi
    lea rsi, [codon10]
    mov qword [rdi + 72], rsi
    lea rsi, [codon11]
    mov qword [rdi + 80], rsi
    lea rsi, [codon12]
    mov qword [rdi + 88], rsi
    lea rsi, [codon13]
    mov qword [rdi + 96], rsi
    lea rsi, [codon14]
    mov qword [rdi + 104], rsi
    lea rsi, [codon15]
    mov qword [rdi + 112], rsi
    lea rsi, [codon16]
    mov qword [rdi + 120], rsi
    lea rsi, [codon17]
    mov qword [rdi + 128], rsi
    mov qword [rdi + 136], 0

    pop rsi
    pop rdi
    ret

fill_aminoacids:
    push rdi
    push rsi

    lea rdi, [aminoacids]
    lea rsi, [amino1]
    mov qword [rdi], rsi
    lea rsi, [amino2]
    mov qword [rdi + 8], rsi
    lea rsi, [amino2]
    mov qword [rdi + 16], rsi
    lea rsi, [amino3]
    mov qword [rdi + 24], rsi
    lea rsi, [amino3]
    mov qword [rdi + 32], rsi
    lea rsi, [amino4]
    mov qword [rdi + 40], rsi
    lea rsi, [amino4]
    mov qword [rdi + 48], rsi
    lea rsi, [amino4]
    mov qword [rdi + 56], rsi
    lea rsi, [amino4]
    mov qword [rdi + 64], rsi
    lea rsi, [amino5]
    mov qword [rdi + 72], rsi
    lea rsi, [amino5]
    mov qword [rdi + 80], rsi
    lea rsi, [amino6]
    mov qword [rdi + 88], rsi
    lea rsi, [amino6]
    mov qword [rdi + 96], rsi
    lea rsi, [amino7]
    mov qword [rdi + 104], rsi
    lea rsi, [stop]
    mov qword [rdi + 112], rsi
    lea rsi, [stop]
    mov qword [rdi + 120], rsi
    lea rsi, [stop]
    mov qword [rdi + 128], rsi
    mov qword [rdi + 136], 0

    pop rsi
    pop rdi
    ret

global proteins
proteins: 
    ; rdi - string representing rna sequence
    ; rsi - output buffer of strings
    ; output buffer is modified in place, adding the corresponding proteins
    ; output buffer address is returned in rax

    lea rax, [data_set]
    cmp byte [rax], 0
    jne start

    call fill_codons
    call fill_aminoacids
    mov byte [rax], 1
    
start:
    mov r10, rsi ; saves output buffer
    mov rsi, rdi ; saves input string 
    xor r11, r11 ; output array counter
restart:
    lea rdi, [current_codon]
    mov rcx, 3
codon_loop:
    lodsb
    stosb
    loop codon_loop    
     
    mov r8b, al

    call find_codon
    
    cmp rcx, 17
    je proteins_end
    
    lea r9, [aminoacids]
    mov rax, [r9 + 8*rcx]
    lea rdx, [stop]
    cmp rax, rdx
    je proteins_end
    
    mov qword [r10 + 8*r11], rax
    inc r11
    test r8b, r8b
    jne restart
proteins_end:
    mov qword [r10 + 8*r11], 0
    lea rax, [r10]
    ret
    
%ifidn __OUTPUT_FORMAT__,elf64
section .note.GNU-stack noalloc noexec nowrite progbits
%endif

