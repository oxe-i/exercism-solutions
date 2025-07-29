#include "pascals_triangle.h"

namespace pascals_triangle {
    auto generate_rows(int64_t rows) -> std::vector<std::vector<int>> {
        if (rows < 0) {
            throw std::domain_error("number of rows must be greater than or equal to 0.");
        }

        if (rows == 0) {
            return std::vector<std::vector<int>>{};
        }
        else if (rows == 1) {
            return std::vector<std::vector<int>>{{1}};
        }
        else if (rows == 2) {
            return std::vector<std::vector<int>>{{1}, {1, 1}};
        }

        auto partial_rows = generate_rows(rows - 1);
        auto last_row = partial_rows.back();
        auto new_row = std::vector<int>{1};

        std::transform(last_row.cbegin(), last_row.cend() - 1,
            last_row.cbegin() + 1, std::back_inserter(new_row), std::plus{});

        new_row.emplace_back(1);
        
        partial_rows.emplace_back(std::move(new_row));

        return partial_rows;        
    }
}  // namespace pascals_triangle
