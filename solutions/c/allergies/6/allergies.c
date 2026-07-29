#include "allergies.h"

#include <stdint.h>
#include <string.h>

bool is_allergic_to(allergen_t allergen, unsigned score) {
    return (1u << allergen) & score;
}

static void scalar_store(allergen_list_t *list, unsigned valid) {
    uint64_t bytes = ((uint64_t)valid * 0x0101010101010101ULL) & 0x8040201008040201ULL;
    bytes = ~(0x8080808080808080ULL - bytes) & 0x8080808080808080ULL; // each byte <= 0x80
    bytes >>= 7;
    memcpy(list->allergens, &bytes, 8);
}

#if defined(__x86_64__)
    #include <immintrin.h>

    __attribute__((target("avx512bw,avx512vl")))
    static void avx_512_store(allergen_list_t *list, unsigned valid) {
        _mm_mask_storeu_epi8(list->allergens, (uint16_t)valid, _mm_set1_epi8(1));
    }
    
    __attribute__((target("bmi2")))
    static void pdep_store(allergen_list_t *list, uint64_t valid) {
        const uint64_t bytes = _pdep_u64(valid, 0x0101010101010101ULL);
        memcpy(list->allergens, &bytes, 8);
    }
    
    allergen_list_t get_allergens(unsigned score) {
        const unsigned valid = score & 0xFF;
        allergen_list_t list = { .count = __builtin_popcount(valid) };
         
        if (__builtin_cpu_supports("avx512bw") && __builtin_cpu_supports("avx512vl")) 
            avx_512_store(&list, valid);
        else if (__builtin_cpu_supports("bmi2")) 
            pdep_store(&list, valid);
        else scalar_store(&list, valid);
        
        return list;
    }

#else

    allergen_list_t get_allergens(unsigned score) {
        const unsigned valid = score & 0xFF;
        allergen_list_t list = { .count = __builtin_popcount(valid) };
        scalar_store(&list, valid);
        return list;
    }

#endif
