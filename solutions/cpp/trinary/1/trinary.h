#if !defined(TRINARY_H)
#define TRINARY_H

#include <cstdint>
#include <string>
#include <algorithm>
#include <numeric>
#include <cmath>

namespace trinary {
    auto to_decimal(const std::string& trinary) -> uint64_t;
}  // namespace trinary

#endif // TRINARY_H