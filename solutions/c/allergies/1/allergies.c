#include "allergies.h"

bool is_allergic_to(allergen_t allergen, unsigned score) {
    return score & (1U << allergen);
}

allergen_list_t get_allergens(unsigned score) {
    score &= 255;
    allergen_list_t list = { 0 };
    list.count = __builtin_popcount(score);
                                   
    unsigned char index = 0;
    while (score) {
        list.allergens[index++] = score & 1;
        score >>= 1;
    }
    return list;
}