#if !defined(TRIANGLE_H)
#define TRIANGLE_H

#include <stdexcept>

namespace triangle {
    enum class flavor {
        equilateral, 
        isosceles, 
        scalene
    };

    constexpr auto kind(double side1, double side2, double side3) -> triangle::flavor {
        auto is_triangle = [] (auto s1, auto s2, auto s3) {
            return (s1 > 0) and (s2 > 0) and (s3 > 0) and (s1 + s2 >= s3) and (s1 + s3 >= s2) and (s2 + s3 >= s1);
        };

        if (not is_triangle(side1, side2, side3))
            throw std::domain_error("sides don't make a triangle.");

        if (side1 == side2 and side1 == side3) 
            return triangle::flavor::equilateral;
        
        if (side1 != side2 and side1 != side3 and side2 != side3)
            return triangle::flavor::scalene;

        return triangle::flavor::isosceles;      
    }

}  // namespace triangle

#endif // TRIANGLE_H