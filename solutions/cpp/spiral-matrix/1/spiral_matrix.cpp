#include "spiral_matrix.h"

namespace spiral_matrix {
    enum class direction {left, down, right, up};

    template <typename Matrix>
    auto check_right_square(const Matrix& matrix, std::size_t row, std::size_t col) -> bool {
        return col + 1 < matrix[row].size() and not matrix[row][col + 1];
    }

    template <typename Matrix>
    auto check_down_square(const Matrix& matrix, std::size_t row, std::size_t col) -> bool {
        return row < matrix.size() - 1 and not matrix[row + 1][col];
    }

    template <typename Matrix>
    auto check_left_square(const Matrix& matrix, std::size_t row, std::size_t col) -> bool {
        return col > 0 and not matrix[row][col - 1];
    }

    template <typename Matrix>
    auto check_up_square(const Matrix& matrix, std::size_t row, std::size_t col) -> bool {
        return row > 0 and not matrix[row - 1][col];
    }

    template <typename Matrix>
    auto fill(Matrix& matrix, uint32_t value, std::size_t row, std::size_t col, direction path) -> void { 
        matrix[row][col] = value;
        
        switch (path) {
            case direction::right:
                if (check_right_square(matrix, row, col))
                    fill(matrix, value + 1, row, col + 1, direction::right);
                else if (check_down_square(matrix, row, col))
                    fill(matrix, value + 1, row + 1, col, direction::down);
                return;
            case direction::down:     
                if (check_down_square(matrix, row, col))
                    fill(matrix, value + 1, row + 1, col, direction::down);
                else if (check_left_square(matrix, row, col)) 
                    fill(matrix, value + 1, row, col - 1, direction::left);
                return;
            case direction::left:
                if (check_left_square(matrix, row, col))
                    fill(matrix, value + 1, row, col - 1, direction::left);
                else if (check_up_square(matrix, row, col))
                    fill(matrix, value + 1, row - 1, col, direction::up);
                return;
            case direction::up:
                if (check_up_square(matrix, row, col))
                    fill(matrix, value + 1, row - 1, col, direction::up);
                else if (check_right_square(matrix, row, col))
                    fill(matrix, value + 1, row, col + 1, direction::right);
                return;
        } 
    }

    auto spiral_matrix(uint32_t size) -> std::vector<std::vector<uint32_t>> {
        if (size == 0) return {};

        auto matrix = std::vector<std::vector<uint32_t>>(size, std::vector<uint32_t>(size, 0));
        fill(matrix, 1, 0, 0, direction::right);
        return matrix;        
    }
}  // namespace spiral_matrix
