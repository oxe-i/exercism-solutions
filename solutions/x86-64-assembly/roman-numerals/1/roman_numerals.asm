section .text

%macro insert 2
    mov al, %1
    stosb
    sub esi, %2
%endmacro

global roman
roman:
    ; edi - number
    ; rsi - output char buffer
    ; buffer should be modified in place
    ; return is void

    xchg rdi, rsi

    cmp esi, 0
    je end

    cmp esi, 1000
    jge insert_thousand

    cmp esi, 900
    jge insert_ninehundred

    cmp esi, 500
    jge insert_fivehundred

    cmp esi, 400
    jge insert_fourhundred

    cmp esi, 100
    jge insert_hundred

    cmp esi, 90
    jge insert_ninety

    cmp esi, 50
    jge insert_fifty

    cmp esi, 40
    jge insert_forty

    cmp esi, 10
    jge insert_ten

    cmp esi, 9
    jge insert_nine

    cmp esi, 5
    jge insert_five
    
    cmp esi, 4
    jge insert_four

    insert 'I', 1
    xchg rsi, rdi
    call roman
    ret
insert_thousand:
    insert 'M', 1000
    xchg rsi, rdi
    call roman
    ret
insert_ninehundred:
    insert 'C', 0
    insert 'M', 900
    xchg rsi, rdi
    call roman
    ret
insert_fivehundred:
    insert 'D', 500
    xchg rsi, rdi
    call roman
    ret
insert_fourhundred:
    insert 'C', 0
    insert 'D', 400
    xchg rsi, rdi
    call roman
    ret
insert_hundred:
    insert 'C', 100
    xchg rsi, rdi
    call roman
    ret
insert_ninety:
    insert 'X', 0
    insert 'C', 90
    xchg rsi, rdi
    call roman
    ret
insert_fifty:
    insert 'L', 50
    xchg rsi, rdi
    call roman
    ret
insert_forty:
    insert 'X', 0
    insert 'L', 40
    xchg rsi, rdi
    call roman
    ret
insert_ten:
    insert 'X', 10
    xchg rsi, rdi
    call roman
    ret
insert_nine:
    insert 'I', 0
    insert 'X', 9
    xchg rsi, rdi
    call roman
    ret
insert_five:
    insert 'V', 5
    xchg rsi, rdi
    call roman
    ret
insert_four:
    insert 'I', 0
    insert 'V', 4
    xchg rsi, rdi
    call roman
    ret
end:
    insert 0, 0
    xchg rsi, rdi
    ret

%ifidn __OUTPUT_FORMAT__,elf64
section .note.GNU-stack noalloc noexec nowrite progbits
%endif
