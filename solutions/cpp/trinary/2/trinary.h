#if !defined(TRINARY_H)
#define TRINARY_H

#include <cstdint>
#include <string_view>

namespace trinary {
    auto to_decimal(std::string_view trinary) -> uint64_t;
}  // namespace trinary

#endif // TRINARY_H