section .text

%macro check_cell 2
    mov rax, [rsi + 8 * %1]
    bt rax, %2
%endmacro

%macro check_cols 0
    dec r9
    cmp r9, -1
    je %%increase_col

    check_cell r8, r9
    adc r10, 0
%%increase_col:
    add r9, 2
    cmp r9, rcx
    je %%restore_col

    check_cell r8, r9
    adc r10, 0
%%restore_col:
    dec r9
%endmacro

%macro check_rows 0
    dec r8
    cmp r8, -1
    je %%increase_row

    check_cols
    check_cell r8, r9
    adc r10, 0
%%increase_row:
    add r8, 2
    cmp r8, rdx
    je %%restore_row

    check_cols
    check_cell r8, r9
    adc r10, 0
%%restore_row:
    dec r8
    check_cols
%endmacro

global tick
tick:
    ; rdi - buffer array of uint64_t
    ; rsi - input matrix of uint64_t
    ; rdx - row count
    ; rcx - col count
    ; return is void
    mov r8, -1 ; current row
loop_over_rows:
    inc r8
    cmp r8, rdx
    je end_loop
    mov r9, -1 ; current col
    xor r11, r11 ; output row
loop_over_cols:
    inc r9
    cmp r9, rcx
    je epilogue_loop_over_rows
    xor r10, r10 ; neighbours
check_neighbours:
    ; results are accumulated in r10
    check_rows
    cmp r10, 3
    je set_bit ; cell is alive if 3 neighbours are alive, regardless of original state
    check_cell r8, r9
    adc r10, 0 ; increases r10 if cell's original state is alive
    cmp r10, 3 ; true if original state is alive and cell has 2 live neighbours
    jne loop_over_cols
set_bit:
    bts r11, r9
    jmp loop_over_cols
epilogue_loop_over_rows:
    mov qword [rdi + 8 * r8], r11
    jmp loop_over_rows
end_loop:
    mov qword [rdi + 8 * r8], 0
    ret

%ifidn __OUTPUT_FORMAT__,elf64
section .note.GNU-stack noalloc noexec nowrite progbits
%endif
