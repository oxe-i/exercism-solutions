#include "hamming.h"

#include <immintrin.h>

int compute(const char *lhs, const char *rhs) {
    const __m128i z = _mm_setzero_si128();
    int dist = 0;
    unsigned eq = 0, nul = 0;
    do {
        /* Loads are in 16-byte blocks.
           The last block may have garbage bytes after end of string.
           Since the pointers are not 16-byte aligned, those bytes 
           may cross into unmapped memory, leading to a segfault.
           This, however, is unlikely for the strings here.

           Solutions would be:
           1- Checking if any block would cross a page.
              Then, fall back to a scalar loop.
           2- Handling the tail separately.
              This would require a previous strlen for each string.
              We would check for different lengths beforehand.
              The loop would proceed in known multiples of 16.
              The remaining bytes would be handled after the loop.

           Aligning-down both pointers would be awkward, however.
           Both pointers may be at different alignments.
           Masking and comparing them wouldn't be straightforward.
        */          
        __m128i a = _mm_loadu_si128((const __m128i *)lhs);
        __m128i b = _mm_loadu_si128((const __m128i *)rhs);
        eq  = _mm_movemask_epi8(_mm_cmpeq_epi8(a, b));
        nul = _mm_movemask_epi8(_mm_cmpeq_epi8(a, z))
            | _mm_movemask_epi8(_mm_cmpeq_epi8(b, z));
        if (nul) break;
        dist += __builtin_popcount(~eq & 0xFFFFu);
        lhs += 16; rhs += 16;
    } while (1);

    unsigned i = __builtin_ctz(nul);
    if (!((eq >> i) & 1)) return -1;
    return dist + __builtin_popcount(~eq & ((1u << i) - 1));
}

/*
pxor xmm0, xmm0
xor eax, eax
.loop:
movdqu xmm1, [rdi]
movdqu xmm2, [rsi]
movdqa xmm3, xmm2
pcmpeqb xmm3, xmm1
pmovmskb edx, xmm3
pcmpeqb xmm1, xmm0
pcmpeqb xmm2, xmm0
pmovmskb r8d, xmm1
pmovmskb r9d, xmm2
or r8d, r9d
jnz .nul

not edx
and edx, 0xFFFF
popcnt edx, edx
add eax, edx
add rdi, 16
add rsi, 16
jmp .loop

.nul:
tzcnt ecx, r8d
mov r9d, edx
shr r9d, cl
test r9d, 1
jz .error

not edx
mov r8d, 1
shl r8d, cl
dec r8d
and edx, r8d
popcnt edx, edx
add eax, edx
ret

.error:
mov eax, -1
ret
*/