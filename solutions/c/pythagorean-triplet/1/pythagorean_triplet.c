#include "pythagorean_triplet.h"

#include <stdlib.h>
#include <string.h>
#include <stdbool.h>

triplets_t *triplets_with_sum(uint16_t sum) {
    if (sum & 1) {
        triplets_t *triplets = malloc(sizeof(size_t));
        triplets->count = 0;
        return triplets;
    }
    
    triplet_t partial[sum >> 1];
    size_t count = 0;

    for (uint16_t a = 1; ; a++) {
        uint32_t num = sum * (sum - (a << 1));
        uint32_t den = (sum - a) << 1;
        uint16_t b = num / den;
        if (b <= a) break;
        if (num % den == 0) {
            partial[count].a = a;
            partial[count].b = b;
            partial[count].c = sum - a - b;
            count++;
        }
    }

    const size_t arr_sz = count * sizeof(triplet_t);
    triplets_t *triplets = malloc(sizeof(size_t) + arr_sz);
    triplets->count = count;
    memcpy(triplets->triplets, partial, arr_sz);
    
    return triplets;
}

void free_triplets(triplets_t *triplets) {
    free(triplets);
}