#if !defined(RAINDROPS_H)
#define RAINDROPS_H

#include <tuple>

namespace raindrops {
    struct String {
        char string[20];

        constexpr String(const char* stringc) : string{} {
            unsigned index {};
            while (stringc[index] != '\0') {
                string[index] = stringc[index];
                index++;
            }
        }
    };

    constexpr auto compare(const char* fst, const char* snd) -> bool {
        return (*fst == '\0' and *snd == '\0') or
            (*fst == *snd and compare(fst + 1, snd + 1));
    }

    constexpr auto operator==(String fst, String snd) -> bool {
        return compare(fst.string, snd.string);
    }

    constexpr auto is_divisor(unsigned num, unsigned div) -> bool {
        return not (num % div);
    }

    constexpr auto divide(unsigned num, unsigned div) {
        return std::pair{num / div, num % div};
    }

    constexpr auto num_to_string(unsigned num) -> String {
        if (num == 0) return "0";
        
        unsigned digits[20] {};
        unsigned num_of_digits {};
        
        while (num) {
            std::tie(num, digits[num_of_digits]) = divide(num, 10);
            num_of_digits++;
        }

        char num_as_string[20] {};

        num_as_string[num_of_digits] = '\0';
        num_of_digits--;
        
        for (unsigned index {}, last_digit {num_of_digits}; index <= num_of_digits; ++index, --last_digit)
            num_as_string[index] = static_cast<char>('0' + digits[last_digit]);
        
        return num_as_string;
    }

    constexpr auto convert(unsigned num) -> String {
        const auto Pling = is_divisor(num, 3);
        const auto Plang = is_divisor(num, 5);
        const auto Plong = is_divisor(num, 7);

        if (Pling and Plang and Plong)
            return "PlingPlangPlong";
        if (Pling and Plang)
            return "PlingPlang";
        if (Pling and Plong)
            return "PlingPlong";
        if (Pling)
            return "Pling";
        if (Plang and Plong)
            return "PlangPlong";
        if (Plang)
            return "Plang";
        if (Plong)
            return "Plong";

        return num_to_string(num);
    }
}  // namespace raindrops

#endif // RAINDROPS_H