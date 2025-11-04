default rel

FLOOR_ROUND_CONTROL equ 1
CEIL_ROUND_CONTROL equ 2

section .rodata
    BILLABLE_HOURS_IN_DAY dq 8.0
    BILLABLE_DAYS_IN_MONTH dq 22.0
    PERCENT_DIVISOR dq 100.0

section .text

global daily_rate
daily_rate:
    mulsd xmm0, qword [BILLABLE_HOURS_IN_DAY]
    ret

global apply_discount
apply_discount:
    divsd xmm1, qword [PERCENT_DIVISOR]
    mulsd xmm1, xmm0
    subsd xmm0, xmm1
    ret

global monthly_rate
monthly_rate:
    call daily_rate
    call apply_discount 
    mulsd xmm0, qword [BILLABLE_DAYS_IN_MONTH]
    ; roundsd xmm0, xmm0, CEIL_ROUND_CONTROL
    vcvtsd2si rax, xmm0, {ru-sae} ; v variant depends on AVX
                                  ; {ru-sae} is a EVEX encoding
                                  ; ru for "round up"
                                  ; EVEX encoding depends on AVX-512F
                                  ; AVX-512 was introduced in 2017-2018
                                  ; for AMD Zen CPUs, only in 2022
    ret

global days_in_budget
days_in_budget:
    call daily_rate
    call apply_discount
    cvtsi2sd xmm1, rdi
    divsd xmm1, xmm0
    ; roundsd xmm0, xmm1, FLOOR_ROUND_CONTROL
    vcvtsd2si eax, xmm1, {rd-sae} ; EVEX encoding
                                  ; rd for "round down"                   
    ret

%ifidn __OUTPUT_FORMAT__,elf64
section .note.GNU-stack noalloc noexec nowrite progbits
%endif
