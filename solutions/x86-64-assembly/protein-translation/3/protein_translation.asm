section .rodata
codons: dq 0, 0, 0, 0, 0, 0, "Serine", 0, 0, 0, "Leucine", 0
        times 6 dq 0
        dq "Tyrosine", 0, 0, 0, "Serine", 0, 0, 0, "Phenylalanine", 0, 0
        dq "Cysteine", 0, 0, 0, "Tyrosine", 0, 0, 0, "Serine", 0, 0, 0
        dq "Phenylalanine", 0, 0, "Cysteine", 0, 0, 0, 0, 0, 0, 0
        dq "Serine", 0, "Methionine", "Leucine", 0, 0, 0, "Tryptophan"

section .text
global proteins

proteins:
   ; letters in nucleotides, mod 8:
   ; A -> 1
   ; C -> 3
   ; U -> 5
   ; G -> 7
   ; All have bit 0 set
   ; So only bits 1 and 2 distinguish them
   ;
   ; The first letter is always 'A' or 'U'
   ; So a single bit is enough for it
   ;
   ; The total necessary number of bits is:
   ; 1 + 2 + 2 = 5
   ; This means a table with 31 entries is enough
   ;
   ; If stored as qwords, NASM automatically pads the strings:
   ; 1. len < 8 -> remainining bytes are zeroed
   ; 2. len > 8 -> string is split in as many qwords as needed
   ;
   ; Each protein is at most 13 bytes
   ; So storing them as 2 qwords ensures padding
   ;
   ; The function returns an array of pointers
   ; 
   ; Algorithm is:
   ; 1. extracts a dword with a 3-byte codon and the next byte
   ; 2. hash the dword extracting only 5 bits of it
   ; 3. index the protein array using the hash
   ; 4. STOP codons have value 0, so check if the qword is empty
   ; 5. If not, store the address of the protein
   ; 6. Check if the next byte (already extracted) is NUL
   ; 7. If not, loop
   ; 8. At the end, store a NULL pointer
   ;
   ; Note:
   ; Algorithm doesn't actually validate the input
   ; The test with an invalid codon passes by chance
   
   mov rax, rsi       ; return address of the buffer
   
   movzx ecx, byte [rdi]
   test ecx, ecx
   jz .done           ; if empty string, return early
   
   mov edx, 0x00060604
   lea r10, [rel codons]
.loop:
   mov ecx, [rdi]     ; gets the codon and the next byte
   add rdi, 3
 
   pext r8d, ecx, edx ; hash the codon
   shl r8, 4          ; each entry in table is 16-byte wide
   lea r8, [r10 + r8] ; get address of the protein string
   
   mov r9, [r8]       
   test r9, r9 
   jz .done           ; if protein string is empty, STOP codon
   
   ; otherwise, store the codon

   mov [rsi], r8
   add rsi, 8

   test ecx, 0xFF000000
   jnz .loop          ; if top byte is not-empty, loop

   ; otherwise, reached the end
   
.done:
   xor ecx, ecx
   mov [rsi], rcx     ; store a NULL pointet
   ret

%ifidn __OUTPUT_FORMAT__,elf64
section .note.GNU-stack noalloc noexec nowrite progbits
%endif
