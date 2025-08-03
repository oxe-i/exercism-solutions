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
    amino1 db "Methionine", 0
    amino2 db "Phenylalanine", 0
    amino3 db "Leucine", 0
    amino4 db "Serine", 0
    amino5 db "Tyrosine", 0
    amino6 db "Cysteine", 0
    amino7 db "Tryptophan", 0
    aminoacids dq 0, 11, 11, 25, 25, 33, 33, 33, 33, 40, 40, 49, 49, 58

section .bss
    current_codon resb 4

section .text

find_codon:
    push rdi
    push rsi
    lea rdx, [codon1]
    mov rax, -1
find_codon_main_loop:
    cmp rax, 15
    je find_codon_end
    inc rax
    lea rsi, [current_codon]
    mov rdi, rdx
    add rdx, 4
    mov rcx, 3    
    cld
    repe cmpsb
    jne find_codon_main_loop
find_codon_end:
    pop rsi
    pop rdi
    ret

global proteins
proteins: 
    ; rdi - string representing rna sequence
    ; rsi - output buffer of strings
    ; output buffer is modified in place, adding the corresponding proteins
    ; output buffer address is returned in rax

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
    
    cmp rax, 15
    je proteins_end
    
    lea r9, [aminoacids]
    mov r9, [r9 + 8*rax]
    lea rax, [amino1]
    add rax, r9
    
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

