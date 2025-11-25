section .text
global square_root
square_root:
   xor ecx, ecx
   mov edx, edi
.bsearch:
   lea eax, [ecx + edx]
   shr eax, 1
   
   mov esi, eax
   imul esi, eax
   
   lea r8d, [eax + 1]
   lea r9d, [eax - 1]
   
   cmp esi, edi
   cmova edx, r9d
   cmovb ecx, r8d
   
   jne .bsearch
   
   ret

%ifidn __OUTPUT_FORMAT__,elf64
section .note.GNU-stack noalloc noexec nowrite progbits
%endif
