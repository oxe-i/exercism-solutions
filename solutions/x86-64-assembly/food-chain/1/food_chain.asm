%macro animals 2-3
    %define _animal_%1_str %2
    %if %0 = 3
        %define _animal_%1_act %3
    %endif
%endmacro

animals 1, "fly"
animals 2, "spider", "It wriggled and jiggled and tickled inside her."
animals 3, "bird", "How absurd to swallow a bird!"
animals 4, "cat", "Imagine that, to swallow a cat!"
animals 5, "dog", "What a hog, to swallow a dog!"
animals 6, "goat", "Just opened her throat and swallowed a goat!"
animals 7, "cow", "I don't know how she swallowed a cow!"
animals 8, "horse", "She's dead, of course!"

%macro _verses 0
    %assign _i 1
    %rep 8
        _verse_ %+ _i %+ _str : 
                db "I know an old lady who swallowed a ", _animal_ %+ _i %+ _str , ".", 10
            %if _i > 1
                db _animal_ %+ _i %+ _act , 10
            %endif
            %if _i < 8
                %assign _k _i
                %assign _j _i - 1
                %rep _j                
                    db "She swallowed the ", _animal_ %+ _k %+ _str , " to catch the ", _animal_ %+ _j %+ _str 
                    %if _j = 2
                        db " that wriggled and jiggled and tickled inside her"
                    %endif
                    db ".", 10
                    %assign _k _k - 1
                    %assign _j _j - 1
                %endrep
                db "I don't know why she swallowed the fly. Perhaps she'll die.", 10
            %endif
        _verse_ %+ _i %+ _len equ $ - _verse_ %+ _i %+ _str
        %assign _i _i + 1
    %endrep
verses: dq 0, 0
    %assign _i 1
    %rep 8
        dq _verse_ %+ _i %+ _str, _verse_ %+ _i %+ _len
        %assign _i _i + 1
    %endrep
%endmacro

section .data.ro.rel
_verses

section .text
global recite
recite:
    lea r11, [rel verses]
    mov eax, esi
    shl eax, 4
    shl edx, 4
.loop:
    mov rsi, qword [r11 + rax]
    mov rcx, qword [r11 + rax + 8]
    rep movsb
    mov byte [rdi], 10
    inc rdi
    add rax, 16
    cmp rax, rdx
    jbe .loop
    mov byte [rdi - 1], 0
    ret

%ifidn __OUTPUT_FORMAT__,elf64
section .note.GNU-stack noalloc noexec nowrite progbits
%endif
