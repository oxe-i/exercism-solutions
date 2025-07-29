#if !defined(DIFFERENCE_OF_SQUARES_H)
#define DIFFERENCE_OF_SQUARES_H

#include <cstdint>
#include <cstddef>

namespace difference_of_squares {
    auto square_of_sum(std::size_t number) -> uint64_t;
    auto sum_of_squares(std::size_t number) -> uint64_t;
    auto difference(std::size_t number) -> uint64_t;
}  // namespace difference_of_squares

#endif // DIFFERENCE_OF_SQUARES_H