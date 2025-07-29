#include "hexadecimal.h"

namespace hexadecimal {
    auto convert(std::string number) -> uint64_t {
        if (const auto invalid_character = std::find_if_not(number.begin(), number.end(),
            [](unsigned char ch) {
                return std::isdigit(ch) or (ch >= 'a' and ch <= 'f');
            }); invalid_character != number.end()) {
            return 0;
        }
        
        return std::transform_reduce(number.rbegin(), number.rend(), uint64_t{}, std::plus{},
            [value_of_digits = &value_of_digits, &number](char& digit) {
                const auto magnitude = std::distance(&digit, &number[number.size() - 1]);
                return (*value_of_digits).at(digit) * std::pow(16, magnitude);
            });
    }
}  // namespace hexadecimal
