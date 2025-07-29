#if !defined(HEXADECIMAL_H)
#define HEXADECIMAL_H

#include <string>
#include <cstdint>
#include <unordered_map>
#include <numeric>
#include <algorithm>
#include <cmath>
#include <iterator>
#include <cctype>

namespace hexadecimal {
    const auto value_of_digits = [] {
        auto map = std::unordered_map<char, int>{};
        
        for (auto digit = '0'; digit <= '9'; ++digit) {
            map[digit] = digit - '0';
        }

        for (auto letter = 'a'; letter <= 'a' + 5; ++letter) {
            map[letter] = (letter - 'a') + 10;
        }

        return map;
    }();

    auto convert(std::string number) -> uint64_t;
}  // namespace hexadecimal

#endif // HEXADECIMAL_H