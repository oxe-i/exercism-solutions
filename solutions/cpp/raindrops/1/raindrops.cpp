#include "raindrops.h"

namespace raindrops {

    template<std::size_t num>
    auto is_divisor_of(const int64_t& number) -> bool {
        return not (number % num);
    }

    auto convert(const int64_t& number) -> std::string {
        auto converted_number = std::string{};        
        
        if (is_divisor_of<3>(number)) {
            converted_number += "Pling";
        }
        
        if (is_divisor_of<5>(number)) {
            converted_number += "Plang";
        }

        if (is_divisor_of<7>(number)) {
            converted_number += "Plong";
        }

        if (converted_number.empty()) {
            converted_number = std::to_string(number);
        }

        return converted_number;
    }
}  // namespace raindrops
