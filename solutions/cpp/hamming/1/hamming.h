#if !defined(HAMMING_H)
#define HAMMING_H

#include <string>
#include <stdexcept>
#include <cstdint>
#include <numeric>

namespace hamming {
    auto compute(const std::string& strand1, const std::string& strand2) -> uint64_t;
}  // namespace hamming

#endif // HAMMING_H