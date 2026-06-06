section .text

global mix_tracks
mix_tracks:
    movdqa xmm0, oword [rsi]
    paddsw xmm0, oword [rdx]
    movdqa oword [rdi], xmm0
    ret

global remove_bleed
remove_bleed:
    movdqa xmm0, oword [rsi]
    movdqu xmm1, oword [rdx]
    psubsw xmm0, xmm1
    movdqu oword [rdi], xmm0
    ret

global combine_meters
combine_meters:
    movdqa xmm0, oword [rsi]
    paddusb xmm0, oword [rdx]
    movdqa oword [rdi], xmm0
    ret

global apply_fade
apply_fade:
    movdqa xmm0, oword [rsi + 2*rcx - 16]
    pmulhw xmm0, oword [rdx + 2*rcx - 16]
    movdqa oword [rdi + 2*rcx - 16], xmm0
    sub rcx, 8
    jnz apply_fade
    ret

global attenuate_track
attenuate_track:
    cvtdq2ps xmm1, oword [rdx]
.loop:
    pmovsxwd xmm0, qword [rsi + 2*rcx - 8]
    cvtdq2ps xmm0, xmm0
    divps xmm0, xmm1
    cvttps2dq xmm0, xmm0
    movdqa oword [rdi + 4*rcx - 16], xmm0
    sub rcx, 4
    jnz .loop
    ret

%ifidn __OUTPUT_FORMAT__,elf64
section .note.GNU-stack noalloc noexec nowrite progbits
%endif
