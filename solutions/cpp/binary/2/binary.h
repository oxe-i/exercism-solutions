#if !defined(BINARY_H)
#define BINARY_H

#include <string_view>

namespace binary {
    auto convert(std::string_view) -> int;
}  // namespace binary

#endif // BINARY_H