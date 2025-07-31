section .text
global rebase

rebase:
    ; contract is
    ; rdi - input array
    ; esi - size of input array
    ; edx - base of input digits
    ; rcx - output array
    ; r8d  - base of output digits
    ; output array should be modified in place

    push rbp

    cmp edx, 1 ; check input base is at least 2
    jle bad_base

    cmp r8d, 1 ; check output base is at least 2
    jle bad_base 

    mov rbp, rcx ; output array
    xor rcx, rcx
    mov ecx, esi ; counter
    sub ecx, 1

    xor r9, r9 ; accumulator
    xor r10, r10 ; exponent
loop:
    ; control flow is
    ; jumps to interlude when current counter is lower than 0
    ; gets current digit in esi and checks if it is valid
    ; if it is, multiplies it to base of input raised to current exponent
    ; adds result to accumulator
    ; increases current exponent
    ; decreases counter

    cmp ecx, 0
    jl interlude

    xor rax, rax
    mov eax, dword [rdi + 4*rcx]

    cmp eax, edx ; check if input digit is less than input base
    jge bad_digit

    cmp eax, 0 ; check if input digit is negative
    js bad_digit

    xor r11, r11 ; current exponent
pow:
    ; raises base of input to current exponent
    ; result is stored in eax
    ; ends loop when current exponent is equal to exponent counter
    cmp r11d, r10d
    je next
    imul eax, edx
    add r11d, 1
    jmp pow

next:
    add r9d, eax
    sub ecx, 1
    add r10d, 1
    jmp loop

interlude:
    ; prepares variables for output proccessing
    xor rcx, rcx ; counter
    xor rax, rax
    mov eax, r9d ; result

count_output:
    ; counts number of elements in output
    ; divides the accumulator (stored in eax) until it becomes 0

    xor edx, edx
    idiv r8d
    add ecx, 1
    cmp eax, 0
    jne count_output

fill_output:
    ; prepares variables for filling output array
    xor rax, rax
    mov eax, r9d
    xor r10, r10
    mov r10d, ecx ; size
    sub ecx, 1

fill_loop:
    ; divides the accumulator (stored in eax) until the counter is less than 0
    ; stores the remainder in the correct position in the output array
    xor edx, edx
    cmp ecx, 0
    jl epilogue
    idiv r8d
    mov dword [rbp + 4*rcx], edx
    sub ecx, 1
    jmp fill_loop

epilogue:
    ; returns the number of elements in output
    mov eax, r10d
    pop rbp
    ret

bad_base:
    mov eax, -1
    pop rbp
    ret

bad_digit:
    mov eax, -2
    pop rbp
    ret

%ifidn __OUTPUT_FORMAT__,elf64
section .note.GNU-stack noalloc noexec nowrite progbits
%endif
