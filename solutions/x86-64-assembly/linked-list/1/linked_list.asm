default rel

section .bss     
    alignb 16 ; to clear using `xmm`
    node_map resq 1 ; bitmap for active nodes
    list_start resb 1 ; index of first node
    list_end resb 1   ; index of last node

    nodes resq 64 ; space for nodes
    ; each node is formed of a data value (dword), a index for previous node (byte), and a index for next node (byte)
    ; two padding bytes are used to align to a 8-byte boundary (for convenience)
    
section .text

; this can be substituted for a lzcnt and a sub
; but this would leave "holes" in the array of nodes, in case of a delete at the middle
%macro find_idx 0
    mov rax, qword [node_map]
    xor ecx, ecx
%%find_bit:
    bt rax, rcx
    jnc %%end_find
    inc ecx
    cmp ecx, 64
    jne %%find_bit
%%end_find:
%endmacro

global list_create
list_create:
        ret

global list_count
list_count:
        popcnt rax, qword [node_map]
        ret

global list_push
list_push:
        find_idx ; index is now in rcx
        lea rax, [nodes]
        movzx rsi, byte [list_end]    
        mov dword [rax + rcx*8], edi      ; insert data
        mov byte [rax + rcx*8 + 4], sil   ; insert prev
        mov byte [rax + rsi*8 + 5], cl    ; insert next in prev node
        mov byte [list_end], cl           ; update end of list
        bts qword [node_map], rcx         ; set node in map
        ret

global list_pop
list_pop:
        movzx rsi, byte [list_end]
        lea rcx, [nodes]
        mov eax, dword [rcx + 8*rsi]      ; get value for return
        movzx rdi, byte [rcx + 8*rsi + 4] ; get prev node
        mov byte [rcx + 8*rdi + 5], 0     ; clear next of prev node
        mov qword [rcx + 8*rsi], 0        ; clear node
        mov byte [list_end], dil          ; update end of list
        btr qword [node_map], rsi         ; reset node in map
        ret

global list_unshift
list_unshift:
        find_idx
        lea rax, [nodes]
        movzx rsi, byte [list_start]
        mov dword [rax + rcx*8], edi    ; insert data
        mov byte [rax + rcx*8 + 5], sil ; insert next
        mov byte [rax + rsi*8 + 4], cl  ; insert prev
        mov byte [list_start], cl       ; update start of list
        bts qword [node_map], rcx       ; set node in map
        ret

global list_shift
list_shift:
        movzx rsi, byte [list_start]       
        lea rcx, [nodes]
        mov eax, dword [rcx + 8*rsi]       ; get value for return
        movzx rdi, byte [rcx + 8*rsi + 5]  ; get next
        mov byte [rcx + 8*rdi + 4], 0      ; clear prev of next
        mov qword [rcx + 8*rsi], 0         ; clear node
        mov byte [list_start], dil         ; update start of list
        btr qword [node_map], rsi          ; clear node in map
        ret

global list_delete
list_delete:
        mov rax, -1
        lea rsi, [nodes]
        mov rdx, qword [node_map]
.find:
        inc rax
        
        cmp rax, 64
        je .end                             ; not found the node in list, do nothing
        
        bt rdx, rax
        jnc .find                           ; node not used, continue
        
        cmp dword [rsi + 8*rax], edi
        jne .find                           ; not found node, continue

        cmp al, byte [list_end]             
        je .pop                             ; node is at the end, go to list_pop

        cmp al, byte [list_start]
        je .shift                           ; node is at the start, go to list_shift
        
        movzx rdi, byte [rsi + 8*rax + 4]   ; get prev
        movzx rcx, byte [rsi + 8*rax + 5]   ; get next
        mov byte [rsi + 8*rdi + 5], cl      ; set next of prev to be next
        mov byte [rsi + 8*rcx + 4], dil     ; set prev of next to be prev
        mov qword [rsi + 8*rax], 0          ; clear node
        btr qword [node_map], rax           ; clear node in map
.end:
        ret   
.pop:
        jmp list_pop                        ; tail call
.shift:
        jmp list_shift                      ; tail call

global list_destroy
list_destroy: 
        vpxor xmm0, xmm0                    ; clear 128-bit in xmm0 (16 bytes)
        vmovaps [node_map], xmm0            ; clears 16 bytes starting at node_map, includes node_map, list_start, list_end and 6 bytes in nodes
        ret

%ifidn __OUTPUT_FORMAT__,elf64
section .note.GNU-stack noalloc noexec nowrite progbits
%endif
