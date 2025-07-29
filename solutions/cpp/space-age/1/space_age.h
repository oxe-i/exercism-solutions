#if !defined(SPACE_AGE_H)
#define SPACE_AGE_H

#include <cstdint>

namespace space_age {

    class space_age {
    private:
        const double earthly_years;
        const uint64_t earthly_seconds;
    public:
        space_age(const uint64_t& time);
        auto on_mercury() const -> double;
        auto on_venus() const -> double;
        auto on_earth() const -> double;
        auto on_mars() const -> double;   
        auto on_jupiter() const -> double;
        auto on_saturn() const -> double;
        auto on_uranus() const -> double;
        auto on_neptune() const -> double;
        auto seconds() const -> uint64_t;
    };

}  // namespace space_age

#endif // SPACE_AGE_H