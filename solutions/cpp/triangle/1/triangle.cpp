#include "triangle.h"

namespace triangle {

    auto kind(const double& side1, const double& side2, const double& side3) -> triangle::flavor {
        auto is_triangle = [] (const auto& s1, const auto& s2, const auto& s3) {
            return (s1 > 0) and (s2 > 0) and (s3 > 0) and (s1 + s2 >= s3) and (s1 + s3 >= s2) and (s2 + s3 >= s1);
        };

        if (not is_triangle(side1, side2, side3)) {
            throw(std::domain_error("invalid parameters"));
        }

        if (side1 == side2 and side1 == side3) {
            return triangle::flavor::equilateral;
        }
        else if (side1 != side2 and side1 != side3 and side2 != side3) {
            return triangle::flavor::scalene;
        }

        return triangle::flavor::isosceles;      
    }

}  // namespace triangle
