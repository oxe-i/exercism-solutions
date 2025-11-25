section .text
global allergic_to
allergic_to:
    ; edi - enum item for allergy
    ; esi - score
    ; output in eax

    bt esi, edi
    setc al
    movzx eax, al
    ret

global list
list:
    ; edi - score
    ; rsi - pointer to item_list struct
    ; struct has one int size and
    ; one array of enum items
    ; struct is modified in place

    movzx edi, dil       ; filters out invalid values
    xchg rdi, rsi
    popcnt eax, esi      ; counts bit sets (num of allergies)
    stosd
.store:   
    test esi, esi
    jz .end
    
    tzcnt eax, esi 
    btr esi, eax
    stosd
    jmp .store
.end:
    ret

%ifidn __OUTPUT_FORMAT__,elf64
section .note.GNU-stack noalloc noexec nowrite progbits
%endif
