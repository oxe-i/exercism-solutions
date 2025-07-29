#if !defined(COLLATZ_CONJECTURE_H)
#define COLLATZ_CONJECTURE_H

#include <cstdint>

namespace collatz_conjecture {
    auto steps(int64_t n) -> uint64_t;
}  // namespace collatz_conjecture

#endif // COLLATZ_CONJECTURE_H