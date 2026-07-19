%macro compare_and_sort 3
    mov %3, %1
    cmp %1, %2
    cmova %1, %2
    cmova %2, %3
%endmacro

section .text
global total
total:
    xor eax, eax
    test rdi, rdi
    jz .done
    
    push r12
    push r13
    sub rsp, 40
    
    vpxor xmm0, xmm0, xmm0
    vmovdqa [rsp], xmm0
    vmovdqa [rsp + 16], xmm0
.count:
    movzx edx, word [rsi + 2*rdi - 2]
    inc dword [rsp + 4*rdx - 4]
    dec rdi
    jnz .count
    
    %assign i 8
    %rep 5
        mov r %+ i %+ d, dword [rsp + 4*(i - 8)]
        %assign i i + 1
    %endrep
    
    compare_and_sort r8d, r11d, edx
    compare_and_sort r9d, r12d, ecx
    
    compare_and_sort r8d, r10d, edx
    compare_and_sort r9d, r11d, ecx
    
    compare_and_sort r8d, r9d, edx
    compare_and_sort r10d, r12d, ecx
    
    compare_and_sort r9d, r10d, edx
    compare_and_sort r11d, r12d, ecx
    
    compare_and_sort r10d, r11d, edx
    ; r8d <= r9d <= r10d <= r11d <= r12d 

    ; books in the largest bucket in excess of the second largest can only go alone
    ; books in the second largest in excess of the third largest can go alone or in pairs
    ; etc

    ; so books in the smallest bucket are the only ones that can go in a 5-book and the other groups get the difference between one bucket and the next smaller one

    ; it is usually best to put books in the largest group to maximize the discount
    ; however, the absolute discount from 3 books to 4 books is largest than from 4 books to 5 books
    ; so, if we have 8 books, it is best to divide them into 2 4-book than into 1 5-book and 1 3-book
    ; calculating manually, this is the only situation when this happens

    ; so we get the min between 3-books and 5-books
    ; remove this amount from each group
    ; and add twice the amout to 4-books
    ; this is equivalent to having 2 4-book for each 3-book that matches a 5-book

    mov esi, r12d
    sub esi, r11d    
    
    mov edi, r11d
    sub edi, r10d              
    
    mov ecx, r10d
    sub ecx, r9d               
    
    mov edx, r9d
    sub edx, r8d              
    
    mov eax, r8d
    cmp ecx, eax
    cmovb eax, ecx  ; min(3-book, 5-book)     
    
    sub r8d, eax    ; remove from 5-book
    sub ecx, eax    ; remove from 3-book      
    lea edx, [edx + eax*2] ; add twice to 4-book

    ; multiply by the price for each group
    imul esi, esi, 800 
    imul edi, edi, 1520
    imul ecx, ecx, 2160
    imul edx, edx, 2560
    imul r8d, r8d, 3000

    ; sum everything
    lea eax, [esi + edi]
    add eax, ecx
    add eax, edx
    add eax, r8d           
    
    add rsp, 40
    pop r13
    pop r12   
    
.done:
    ret
    
%ifidn __OUTPUT_FORMAT__,elf64
section .note.GNU-stack noalloc noexec nowrite progbits
%endif
