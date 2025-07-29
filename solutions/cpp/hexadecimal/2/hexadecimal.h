#if !defined(HEXADECIMAL_H)
#define HEXADECIMAL_H

#include <string_view>

namespace hexadecimal {

    constexpr auto is_valid_hex_digit(char letter) {
        return (letter >= '0' and letter <= '9') or (letter >= 'a' and letter <= 'f');
    }

    constexpr auto map_hex_digit_to_decimal(char letter) {
        if (letter >= '0' and letter <= '9') return letter - '0';
        return 10 + (letter - 'a');
    }

    constexpr auto power(unsigned num, unsigned exp) -> unsigned {
        if (not exp) return 1;
        return exp & 1 ?
            num * power(num * num, exp >> 1) :
            power(num * num, exp >> 1);
    }
    
    constexpr auto convert(std::string_view number_as_string) {
        unsigned number {};
        unsigned magnitude {};
        
        for (auto rit {number_as_string.rbegin()}; rit < number_as_string.rend(); ++rit, ++magnitude) {
            if (not is_valid_hex_digit(*rit)) return 0U;
            number += map_hex_digit_to_decimal(*rit) * power(16, magnitude);
        }
        
        return number;   
    }
}  // namespace hexadecimal

#endif // HEXADECIMAL_H