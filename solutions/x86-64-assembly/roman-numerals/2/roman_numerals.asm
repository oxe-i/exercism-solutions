%macro check 3
   cmp edi, %1
   jb %%end
%%loop:
   mov dword [rsi], %2
   add rsi, %3
   sub edi, %1
   cmp edi, %1
   jae %%loop
%%end:
%endmacro

section .text
global roman
roman:
    check 1000, "M", 1
    check 900, "CM", 2
    check 500, "D", 1
    check 400, "CD", 2
    check 100, "C", 1
    check 90, "XC", 2
    check 50, "L", 1
    check 40, "XL", 2
    check 10, "X", 1
    check 9, "IX", 2
    check 5, "V", 1
    check 4, "IV", 2
    check 1, "I", 1
    ret

%ifidn __OUTPUT_FORMAT__,elf64
section .note.GNU-stack noalloc noexec nowrite progbits
%endif
