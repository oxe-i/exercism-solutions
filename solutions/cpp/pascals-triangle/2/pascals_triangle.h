#if !defined(PASCALS_TRIANGLE_H)
#define PASCALS_TRIANGLE_H

#include <cstdint>
#include <vector>

namespace pascals_triangle {
    auto generate_rows(int64_t) -> std::vector<std::vector<int>>;
}  // namespace pascals_triangle

#endif // PASCALS_TRIANGLE_H