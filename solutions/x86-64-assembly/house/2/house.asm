%macro subject 2-3
    %define _subject_%1_str %2
    %if %0 = 3
        %define _subject_%1_act %3
    %endif
%endmacro

subject 1, `the house that Jack built.\n`, "lay in"
subject 2, "the malt", "ate"
subject 3, "the rat", "killed"
subject 4, "the cat", "worried"
subject 5, "the dog", "tossed"
subject 6, "the cow with the crumpled horn", "milked"
subject 7, "the maiden all forlorn", "kissed"
subject 8, "the man all tattered and torn", "married"
subject 9, "the priest all shaven and shorn", "woke"
subject 10, "the rooster that crowed in the morn", "kept"
subject 11, "the farmer sowing his corn", "belonged to"
subject 12, "the horse and the hound and the horn"

%macro _verse 1
    _verse_ %+ %1 %+ _str : db "This is ", _subject_ %+ %1 %+ _str
                            %assign _i %1 - 1
                            %rep %1 - 1
                                db " that "
                                db _subject_ %+ _i %+ _act, " "
                                db _subject_ %+ _i %+ _str
                                %assign _i _i - 1
                            %endrep
    _verse_ %+ %1 %+ _len equ $ - _verse_ %+ %1 %+ _str
%endmacro

%macro _verses 0
    %assign _j 1
    %rep 12
        _verse _j
        %assign _j _j + 1
    %endrep
verses: dq 0, 0
    %assign _j 1
    %rep 12
        dq _verse_ %+ _j %+ _str, _verse_ %+ _j %+ _len
        %assign _j _j + 1
    %endrep
%endmacro

section .data

_verses

section .text
global recite
recite:
    lea r8d, [esi + esi]
    lea edx, [edx + edx]
    lea r10, [rel verses]
.loop:
    mov rsi, [r10 + 8*r8]
    mov rcx, [r10 + 8*r8 + 8]
    rep movsb

    add r8d, 2
    cmp r8d, edx
    jbe .loop
    
    mov byte [rdi], 0
    ret

%ifidn __OUTPUT_FORMAT__,elf64
section .note.GNU-stack noalloc noexec nowrite progbits
%endif
