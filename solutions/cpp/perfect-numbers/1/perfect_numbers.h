#if !defined(PERFECT_NUMBERS_H)
#define PERFECT_NUMBERS_H

#include <cstdint>
#include <stdexcept>
#include <cmath>
#include <iostream>

namespace perfect_numbers {
   constexpr auto deficient = uint8_t{0};
   constexpr auto perfect = uint8_t{1};
   constexpr auto abundant = uint8_t{2};

   auto classify(const int64_t number) -> uint8_t;
}  // namespace perfect_numbers

#endif  // PERFECT_NUMBERS_H