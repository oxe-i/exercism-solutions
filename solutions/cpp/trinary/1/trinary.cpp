#include "trinary.h"

namespace trinary {
    auto to_decimal(const std::string& trinary) -> uint64_t {
        if (const auto invalid_char = std::find_if_not(trinary.cbegin(), trinary.cend(),
            [](char element){
                return (element >= '0' and element <= '2');
            }); 
            invalid_char != trinary.cend()) {
            return 0;
        }

        const auto last_index = trinary.size() - 1;

        return std::transform_reduce(trinary.crbegin(), trinary.crend(), 0ULL, std::plus{},
            [&trinary, &last_index](const auto& element) {
                const auto magnitude = std::distance(&element, &trinary[last_index]);
                const auto multiplier = element - '0';
                
                return multiplier * (std::pow(3, magnitude));
            });
    }
}  // namespace trinary
