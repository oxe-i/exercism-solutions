#include "eliuds_eggs.h"

unsigned egg_count(unsigned encode) {
    return __builtin_popcount(encode);
}
