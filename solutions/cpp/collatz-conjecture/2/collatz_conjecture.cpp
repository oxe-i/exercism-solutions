#include "collatz_conjecture.h"

#include <stdexcept>

namespace collatz_conjecture {
    auto is_even(uint64_t n) {
        return not (n & 1);
    }

    auto steps(int64_t n) -> uint64_t {
        if (n < 1)
            throw std::domain_error("Invalid input");
        
        if (n == 1) return 0;       
        return 1 + (is_even(n) ? steps(n >> 1) : steps((3 * n) + 1));
    }

}  // namespace collatz_conjecture
