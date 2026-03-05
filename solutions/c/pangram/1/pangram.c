#include "pangram.h"

#include <stddef.h>

bool is_pangram(const char *sentence) {
    if (sentence == NULL) return false;

    int bmp = 0;
    for (int i = 0; sentence[i] != '\0'; ++i) {
        const int idx = (sentence[i] | 32) - 'a';
        if ((unsigned)(idx) >= 26) continue;
        bmp |= (1 << idx);
    }

    return bmp == ((1 << 26) - 1);
}
