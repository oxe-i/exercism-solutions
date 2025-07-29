#include "pascals_triangle.h"

#include <stdexcept>
#include <algorithm>

namespace pascals_triangle {
    auto generate_rows(int64_t rows) -> std::vector<std::vector<int>> {
        if (rows < 0) throw std::domain_error("number of rows can't be negative.");
        if (rows == 0) return {};
        if (rows == 1) return {{1}};
        
        auto triangle = std::vector<std::vector<int>>{{1}, {1, 1}};

        for (auto crt_row = 2; crt_row < rows; ++crt_row)
        {
            const auto& last_row = triangle.back();
            auto new_row = std::vector<int>(last_row.size() + 1, 1);
            std::transform(
                last_row.begin(), last_row.end() - 1,
                last_row.begin() + 1, new_row.begin() + 1,
                std::plus{}
            );
            triangle.push_back(new_row);
        }

        return triangle;     
    }
}  // namespace pascals_triangle
