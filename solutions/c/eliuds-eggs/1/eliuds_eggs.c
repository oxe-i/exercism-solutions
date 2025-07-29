#include "eliuds_eggs.h"

__attribute__((const))
unsigned egg_count(unsigned encode) {
    return __builtin_popcount(encode);
}
