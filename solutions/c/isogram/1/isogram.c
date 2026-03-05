#include "isogram.h"

#include <stddef.h>

bool is_isogram(const char phrase[]) {
    if (phrase == NULL) return false;
    
    int bmp = 0;
    for (int i = 0; phrase[i] != '\0'; ++i) {
        const int idx = (phrase[i] | 32) - 'a';
        if ((unsigned)(idx) >= 26) continue;
        const int bit = 1 << idx;
        if (bmp & bit) return false;
        bmp |= bit;
    }

    return true;
}
