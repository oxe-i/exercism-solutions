#include "space_age.h"

namespace space_age {
    
        space_age::space_age(const uint64_t& time) : earthly_years{static_cast<double>(time) / 31557600}, earthly_seconds{time} {}

        auto space_age::on_mercury() const -> double {
            return space_age::earthly_years / 0.2408467;
        }

        auto space_age::on_venus() const -> double {
            return space_age::earthly_years / 0.61519726;
        }

        auto space_age::on_earth() const -> double {
            return space_age::earthly_years;
        }

        auto space_age::on_mars() const -> double {
            return space_age::earthly_years / 1.8808158;
        }   

        auto space_age::on_jupiter() const -> double {
            return space_age::earthly_years / 11.862615;
        }

        auto space_age::on_saturn() const -> double {
            return space_age::earthly_years / 29.447498;
        }

        auto space_age::on_uranus() const -> double {
            return space_age::earthly_years / 84.016846;
        }

        auto space_age::on_neptune() const -> double {
            return space_age::earthly_years / 164.79132;
        }

        auto space_age::seconds() const -> uint64_t {
            return space_age::earthly_seconds;
        }
}  // namespace space_age
