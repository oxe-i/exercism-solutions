#include "grains.h"

namespace grains {
    auto square(const uint8_t& input) -> uint64_t {
        if (input < 1 or input > 64) {
            throw(std::domain_error("invalid argument"));
        }

        const auto index = input - 1;
        
        return board[index];
    }

    auto total() -> uint64_t {
        return sum;
    }
}  // namespace grains
