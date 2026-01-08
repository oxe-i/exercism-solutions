section .data
    days dq 0, 0, "first", 5, "second", 6, "third", 5, "fourth", 6, "fifth", 5, "sixth", 5, "seventh", 7, "eighth", 6, "ninth", 5, "tenth", 5, "eleventh", 8, "twelfth", 7
    
    entrance db " day of Christmas my true love gave to me: "
    szent equ $ - entrance
    
    one db "a Partridge in a Pear Tree"
    sz1 equ $ - one
    two db "two Turtle Doves"
    sz2 equ $ - two
    three db "three French Hens"
    sz3 equ $ - three
    four db "four Calling Birds"
    sz4 equ $ - four
    five db "five Gold Rings"
    sz5 equ $ - five
    six db "six Geese-a-Laying"
    sz6 equ $ - six
    seven db "seven Swans-a-Swimming"
    sz7 equ $ - seven
    eight db "eight Maids-a-Milking"
    sz8 equ $ - eight
    nine db "nine Ladies Dancing"
    sz9 equ $ - nine
    ten db "ten Lords-a-Leaping"
    sz10 equ $ - ten
    eleven db "eleven Pipers Piping"
    sz11 equ $ - eleven
    twelve db "twelve Drummers Drumming"
    sz12 equ $ - twelve

    things dq 0, one, two, three, four, five, six, seven, eight, nine, ten, eleven, twelve
    sizes dq 0, sz1, sz2, sz3, sz4, sz5, sz6, sz7, sz8, sz9, sz10, sz11, sz12

section .text
global recite
recite:
    ; recurse until start verse > last verse
    
    mov eax, esi
    mov r9d, eax

    ; start of entrance
    mov rcx, "On the "
    mov qword [rdi], rcx
    add rdi, 7

    ; ordinal for day
    lea ecx, [eax + eax]           ; each day occupies two qwords, one for the string and another for its size
    lea r11, [rel days]
    mov r10, qword [r11 + 8*rcx]   ; gets string
    mov qword [rdi], r10           ; inserts string in buffer
    add rdi, qword [r11 + 8*rcx + 8] ; increments buffer pointer by size

    ; end of entrance
    lea rsi, [rel entrance]
    mov rcx, szent
    rep movsb

    ; loop adding things until there is none
    lea r11, [rel things]
    lea r10, [rel sizes]    
.add_things:
    mov rsi, qword [r11 + 8*rax] ; address for the thing to be added
    mov rcx, qword [r10 + 8*rax] ; size of the thing to be added
    rep movsb

    mov rcx, ", "      ; if day > 2, add comma in preparation for next thing
    mov r8, `.\n`      ; if day == 1, it's the last thing. Add newline in preparation for next verse
    mov rsi, ", and "  ; if day == 2, add comma and "and "

    ; conditional move to dispatch string
    cmp eax, 2
    cmovb rcx, r8      
    cmove rcx, rsi

    mov qword [rdi], rcx  ; add string to buffer
    
    lea rcx, [rdi + 6]    ; if day == 2, size of string is 6
    add rdi, 2            ; otherwise, it is 2

    ; conditional move to dispatch size
    cmp eax, 2
    cmove rdi, rcx
    
    dec eax
    jnz .add_things       ; loops until eax == 0

    ; prepare for tail call
    lea esi, [r9d + 1]    ; moves esi to next verse
    cmp esi, edx                  
    jbe recite            ; tail call if start verse <= last verse

    ; since delimiter strings are added as qwords, all exceding bytes are already 0 (NUL)
    ; so no need to add NUL at the end
    ret

%ifidn __OUTPUT_FORMAT__,elf64
section .note.GNU-stack noalloc noexec nowrite progbits
%endif
