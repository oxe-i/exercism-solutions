#if !defined(PASCALS_TRIANGLE_H)
#define PASCALS_TRIANGLE_H

#include <cstdint>
#include <vector>
#include <stdexcept>
#include <algorithm>

namespace pascals_triangle {
    auto generate_rows(int64_t rows) -> std::vector<std::vector<int>>;
}  // namespace pascals_triangle

#endif // PASCALS_TRIANGLE_H