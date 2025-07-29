#include "say.h"

#include <stdexcept>
#include <array>

namespace say {

    constexpr auto first_10 = std::array<const char*, 10> {
        "zero", "one", "two", "three", "four", "five", "six", "seven", "eight", "nine"
    };

    constexpr auto teens = std::array<const char*, 10> {
        "ten", "eleven", "twelve", "thirteen", "fourteen", "fifteen", "sixteen", "seventeen", "eighteen", "nineteen"
    };

    constexpr auto tens = std::array<const char*, 8> {
        "twenty", "thirty", "forty", "fifty", "sixty", "seventy", "eighty", "ninety"
    };

    auto in_english(int64_t number) -> std::string {
        if (number < 0 or number > 999'999'999'999) 
        {
            throw std::domain_error("number outside allowed range.");
        }

        if (number < 10)
        {
            return first_10[number];
        }

        if (number >= 10 and number < 20)
        {
            return teens[number - 10];
        }

        if (number >= 20 and number < 100)
        {
            return std::string{tens[(number / 10) - 2]} + (number % 10 != 0 ? "-" + std::string{first_10[number % 10]} : "");
        }

        if (number >= 100 and number < 1'000) 
        {
            return in_english(number / 100) + " hundred" + 
                (number % 100 != 0 ? " " + in_english(number % 100) : "");
        }

        if (number >= 1'000 and number < 1'000'000)
        {
            return in_english(number / 1'000) + " thousand" +
                (number % 1'000 != 0 ? " " + in_english(number % 1'000) : "");
        }

        if (number >= 1'000'000 and number < 1'000'000'000)
        {
            return in_english(number / 1'000'000) + " million" +
                (number % 1'000'000 != 0 ? " " + in_english(number % 1'000'000) : "");
        }

        return in_english(number / 1'000'000'000) + " billion" +
                (number % 1'000'000'000 != 0 ? " " + in_english(number % 1'000'000'000) : "");
    }
}  // namespace say
