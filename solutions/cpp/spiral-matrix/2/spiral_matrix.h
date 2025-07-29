#if !defined(SPIRAL_MATRIX_H)
#define SPIRAL_MATRIX_H

#include <cstdint>
#include <vector>

namespace spiral_matrix {
    using matrix_t = std::vector<std::vector<uint32_t>>;
    auto spiral_matrix(uint32_t size) -> matrix_t;
}  // namespace spiral_matrix

#endif  // SPIRAL_MATRIX_H
