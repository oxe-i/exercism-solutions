%macro _nums 1-*
    %assign _i 0
    %rep %0
        %define %[_num_ %+ _i %+ _lo] %1
        %substr %[_st %+ _i] %1 1
        %substr %[_tl %+ _i] %1 2, -1
        %define %[_num_ %+ _i %+ _up] %[_st %+ _i] & ~32, %[_tl %+ _i]
        %rotate 1
        %assign _i _i + 1
    %endrep
    %undef _i
%endmacro

_nums "no", "one", "two", "three", "four", "five", "six", "seven", "eight", "nine", "ten"

%macro _verses 0
    %assign _i 10
    %rep 10
        _num_ %+ _i %+ _str : 
            %rep 2
                db _num_ %+ _i %+ _up, " green bottle"
                %if _i != 1
                    db "s"
                %endif
                db " hanging on the wall,", 10
            %endrep
        %assign _j _i - 1
            db "And if one green bottle should accidentally fall,", 10
            db "There'll be ", _num_ %+ _j %+ _lo, " green bottle"
            %if _j != 1
                db "s"
            %endif
            db " hanging on the wall.", 10, 10
        _num %+ _i %+ _len equ $ - _num_ %+ _i %+ _str 
        %assign _i _j
    %endrep
    %assign _i 1
verses: dq 0, 0
    %rep 10
       dq _num_ %+ _i %+ _str, _num %+ _i %+ _len
       %assign _i _i + 1
    %endrep
    %undef _i
    %undef _j
%endmacro       

section .data
_verses

section .text
global recite
recite:
    lea eax, [esi + esi]
    lea r10, [rel verses]
.loop:
    mov rsi, [r10 + 8*rax]
    mov rcx, [r10 + 8*rax + 8]
    rep movsb
    sub eax, 2
    dec edx
    jnz .loop
    mov byte [rdi - 1], 0
    ret

%ifidn __OUTPUT_FORMAT__,elf64
section .note.GNU-stack noalloc noexec nowrite progbits
%endif
