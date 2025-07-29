#include "roman_numerals.h"

namespace roman_numerals {

    auto conversion_per_magnitude(char unity, char five_unities, char ten_unities, uint8_t value) {
        auto converted_chars = std::string{};
        
        switch (value) {
            case 0:
                break;
            case 1:
            case 2:
            case 3:
                std::fill_n(std::back_inserter(converted_chars), value, unity);
                break;
            case 4:
                converted_chars.push_back(unity);
                converted_chars.push_back(five_unities);
                break;
            case 5:
                converted_chars.push_back(five_unities);
                break;
            case 6:
            case 7:
            case 8:
                converted_chars.push_back(five_unities);
                std::fill_n(std::back_inserter(converted_chars), value - 5, unity);
                break;
            case 9:
                converted_chars.push_back(unity);
                converted_chars.push_back(ten_unities);
                break;
        }

        return converted_chars;
    }

    auto convert(int64_t number) -> std::string {
        if (number > 3'999) {
            throw std::domain_error("number is too big.");
        }
        else if (number < 1) {
            throw std::domain_error("roman numerals can't be zero or negative.");
        }

        auto roman = std::string{};

        const auto thousands = number / 1000;
        const auto hundreds = (number / 100) % 10;
        const auto tens = (number / 10) % 10;
        const auto digits = number % 10;
       
        std::fill_n(std::back_inserter(roman), thousands, 'M');

        roman.append(conversion_per_magnitude('C', 'D', 'M', hundreds));
        roman.append(conversion_per_magnitude('X', 'L', 'C', tens));
        roman.append(conversion_per_magnitude('I', 'V', 'X', digits));       

        return roman;
    }
}  // namespace roman_numerals
