#define _POSIX_C_SOURCE 200809L

#include "nucleotide_count.h"

#include <stdlib.h>
#include <stdint.h>
#include <stdio.h>
#include <string.h>
#include <inttypes.h>
#include <stdbool.h>
#include <immintrin.h>

char *count(const char *dna_strand) {
    __m256i cs = _mm256_setzero_si256();
    const __m256i ns = _mm256_set_epi64x('T','G','C','A');

    bool valid = true;
    for (int i = 0; dna_strand[i] != '\0'; ++i) {
        __m256i vn = _mm256_set1_epi64x(dna_strand[i]);
        __m256i cn = _mm256_cmpeq_epi64(vn, ns);
        valid = valid && !_mm256_testz_si256 (cn, cn);
        cs = _mm256_sub_epi64(cs, cn);
    }

    if (!valid) return strdup("");

    uint64_t ls[4];
    _mm256_storeu_si256((__m256i*)ls, cs);
    
    char *buf = malloc(92);
    if (!buf) return NULL;
    snprintf(buf, 92, "A:%" PRIu64 " C:%" PRIu64 " G:%" PRIu64 " T:%" PRIu64, ls[0], ls[1], ls[2], ls[3]);

    return buf;
}