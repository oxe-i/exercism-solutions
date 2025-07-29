#if !defined(ARMSTRONG_NUMBERS_H)
#define ARMSTRONG_NUMBERS_H

#include <cstdint>
#include <numeric>
#include <string>
#include <cmath>

namespace armstrong_numbers {
   auto is_armstrong_number(uint64_t number) -> bool;
}  // namespace armstrong_numbers

#endif // ARMSTRONG_NUMBERS_H