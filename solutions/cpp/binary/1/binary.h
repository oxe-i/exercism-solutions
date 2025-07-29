#if !defined(BINARY_H)
#define BINARY_H

#include <bitset>
#include <algorithm>
#include <string>
#include <cstdint>

namespace binary {
    auto convert(const std::string& bit_string) -> uint64_t;
}  // namespace binary

#endif // BINARY_H