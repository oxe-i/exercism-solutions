#include "darts.h"

enum { INNER_SQ = 1, MIDDLE_SQ = 5 * 5, OUTER_SQ = 10 * 10 };

uint8_t score(coordinate_t pos) {
    const float dsquare = pos.x * pos.x + pos.y * pos.y;
    return dsquare <= INNER_SQ? 10 : dsquare <= MIDDLE_SQ? 5 : dsquare <= OUTER_SQ? 1 : 0;
}
