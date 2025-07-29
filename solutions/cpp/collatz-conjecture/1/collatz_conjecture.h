#if !defined(COLLATZ_CONJECTURE_H)
#define COLLATZ_CONJECTURE_H

#include <stdexcept>
#include <cstdint>

namespace collatz_conjecture {
    auto is_even(const uint64_t& n);
    auto steps(const int64_t& n) -> uint64_t;
}  // namespace collatz_conjecture

#endif // COLLATZ_CONJECTURE_H