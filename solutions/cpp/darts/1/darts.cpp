#include "darts.h"

namespace darts {
    auto score(double x, double y) -> int {
        const auto sum_of_squares = (x * x) + (y * y);

        if (sum_of_squares > square_of_outer_radius) {
            return missed;
        }
        if (sum_of_squares > square_of_middle_radius) {
            return outer_circle;
        }
        if (sum_of_squares > square_of_inner_radius) {
            return middle_circle;
        }

        return bullseye;
    }
} // namespace darts