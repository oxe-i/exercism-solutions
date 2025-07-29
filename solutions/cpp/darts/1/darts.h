#if !defined(DARTS_H)
#define DARTS_H

namespace darts {
    namespace {
        constexpr double square_of_outer_radius = 100.0;
        constexpr double square_of_middle_radius = 25.0;
        constexpr double square_of_inner_radius = 1.0;

        constexpr int missed = 0;
        constexpr int outer_circle = 1;
        constexpr int middle_circle = 5;
        constexpr int bullseye = 10;
    }

    auto score(double x, double y) -> int;
} // namespace darts

#endif //DARTS_H