#include "difference_of_squares.h"

namespace difference_of_squares {
    auto square_of_sum(std::size_t number) -> uint64_t {
        const auto sum_of_numbers = (number * (number + 1)) / 2;
        return sum_of_numbers * sum_of_numbers;
    }
    
    auto sum_of_squares(std::size_t number) -> uint64_t {
        return (number * (number + 1) * ((2 * number) + 1)) / 6;        
    }

    auto difference(std::size_t number) -> uint64_t {
        return square_of_sum(number) - sum_of_squares(number);
    }
}  // namespace difference_of_squares
