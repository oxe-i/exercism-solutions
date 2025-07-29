#if !defined(TRIANGLE_H)
#define TRIANGLE_H

#include <stdexcept>

namespace triangle {
    enum class flavor {
        equilateral, 
        isosceles, 
        scalene
    };

    auto kind(const double& side1, const double& side2, const double& side3) -> triangle::flavor;

}  // namespace triangle

#endif // TRIANGLE_H