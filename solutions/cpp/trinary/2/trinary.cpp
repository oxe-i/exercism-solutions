#include "trinary.h"

#include <algorithm>
#include <numeric>
#include <cmath>

namespace trinary {
    auto to_decimal(std::string_view trinary) -> uint64_t {
        if (const auto invalid_char = std::find_if_not(trinary.begin(), trinary.end(),
            [](char element){
                return (element >= '0' and element <= '2');
            }); 
            invalid_char != trinary.end()) {
            return 0;
        }

        const auto last_index = trinary.size() - 1;

        return std::transform_reduce(trinary.rbegin(), trinary.rend(), 0ULL, std::plus{},
            [&](auto& element) {
                const auto magnitude = std::distance(&element, &trinary[last_index]);
                const auto multiplier = element - '0';
                
                return multiplier * (std::pow(3, magnitude));
            });
    }
}  // namespace trinary
