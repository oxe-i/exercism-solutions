#include "eliuds_eggs.h"

unsigned egg_count(unsigned encode) {
    const unsigned x = (encode & 0x55555555) + ((encode >> 1) & 0x55555555);
    const unsigned y = (x & 0x33333333) + ((x >> 2) & 0x33333333);
    const unsigned z = (y + (y >> 4)) & 0x0F0F0F0F;
    return (z * 0x01010101) >> 24; 
}
