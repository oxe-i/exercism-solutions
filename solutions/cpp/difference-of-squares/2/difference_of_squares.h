#if !defined(DIFFERENCE_OF_SQUARES_H)
#define DIFFERENCE_OF_SQUARES_H

#include <cstdint>

namespace difference_of_squares { 
//operations are only defined for natural (unsigned) numbers
    auto square_of_sum(uint64_t n) -> uint64_t;
    auto sum_of_squares(uint64_t n) -> uint64_t;
    auto difference(uint64_t n) -> uint64_t;
}  // namespace difference_of_squares

#endif // DIFFERENCE_OF_SQUARES_H