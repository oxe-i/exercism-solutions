section .text
global maximumValue

maximumValue:
    ; contract is
    ; rdi is pointer to an array of Input structs
    ; esi is the number of Inputs in the array
    ; edx is maximum weight that can be carried
    ; output is passed in eax
    
    push rbp
    mov rbp, rsp
    sub rsp, 28 ; local variables

    mov qword [rbp - 28], rdi ; save input array
    mov qword [rbp - 20], rsi ; save size of input array
    mov qword [rbp - 12], rdx ; save max weight

    xor rax, rax

    cmp esi, 0 
    je epilogue ; num inputs is 0

    cmp edx, 0
    je epilogue ; max weight is 0

    ; sets first recursion
    ; increases array pointer by one
    ; decreases num items by one
    ; gets max value for the remainder of the array
    ; without considering current item

    add rdi, 8
    sub esi, 1

    call maximumValue

    ; restore local variables after recursion

    mov rdi, qword [rbp - 28]
    mov rsi, qword [rbp - 20]
    mov rdx, qword [rbp - 12]

    ; if current weight is greater than max weight
    ; then current item doesn't contribute to max value
    ; so the max value of the array equals to the result already 
    ; calculated in the first recursion and stored in eax
    ; so the function can return safely

    cmp dword [rdi + 4], edx
    ja epilogue

    ; if current weight is less than, or equal to, max weight
    ; then current item might contribute to max value
    ; and the overall max value of the array is the max between
    ; the result already calculated, without considering current item,
    ; and the result considering current item

    ; result for the first recursion must be saved
    ; before doing a second recursion

    mov dword [rbp - 4], eax

    ; sets second recursion, increasing array pointer by 1
    ; reducing item count by 1
    ; and reducing max weight by current weight

    sub edx, dword [rdi + 4]
    add rdi, 8
    sub esi, 1
    
    call maximumValue

    ; restore variables

    mov rdi, qword [rbp - 28]
    mov rsi, qword [rbp - 20]
    mov rdx, qword [rbp - 12]

    ; sums current value to the result of the second recursion

    add eax, dword [rdi]

    ; checks if the result considering the current item is greater
    ; than the result without considering it
    ; if it is, eax already holds the greater value
    ; and the function can return

    cmp eax, dword [rbp - 4]
    jae epilogue

    ; if not, move the greater result to eax

    mov eax, dword [rbp - 4]
epilogue:
    ; restore call frame
    
    mov rsp, rbp
    pop rbp
    ret


%ifidn __OUTPUT_FORMAT__,elf64
section .note.GNU-stack noalloc noexec nowrite progbits
%endif

