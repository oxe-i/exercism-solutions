#include "darts.h"

namespace {
constexpr auto square_of_outer_radius = 100.0;
constexpr auto square_of_middle_radius = 25.0;
constexpr auto square_of_inner_radius = 1.0;

constexpr auto missed = 0;
constexpr auto outer_circle = 1;
constexpr auto middle_circle = 5;
constexpr auto bullseye = 10;
}

namespace darts {
    auto score(double x, double y) -> int {
        const auto sum_of_squares = (x * x) + (y * y);

        if (sum_of_squares > square_of_outer_radius)
            return missed;
        
        if (sum_of_squares > square_of_middle_radius)
            return outer_circle;

        if (sum_of_squares > square_of_inner_radius)
            return middle_circle;

        return bullseye;
    }
} // namespace darts