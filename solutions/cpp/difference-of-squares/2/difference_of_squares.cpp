#include "difference_of_squares.h"

#include <cmath>

namespace difference_of_squares {
    auto sum_of_n_naturals(uint64_t n) -> uint64_t {
        return (n * (n + 1)) >> 1;
    }

    auto square_of_sum(uint64_t n) -> uint64_t {
        return std::pow(sum_of_n_naturals(n), 2) ;
    }

    auto sum_of_squares(uint64_t n) -> uint64_t {
        return (sum_of_n_naturals(n) * ((n << 1) + 1)) / 3;
    }

    auto difference(uint64_t n) -> uint64_t {
        return square_of_sum(n) - sum_of_squares(n);
    }
}  // namespace difference_of_squares
