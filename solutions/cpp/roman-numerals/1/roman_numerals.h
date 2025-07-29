#if !defined(ROMAN_NUMERALS_H)
#define ROMAN_NUMERALS_H

#include <cstdint>
#include <string>
#include <stdexcept>
#include <algorithm>

namespace roman_numerals {
    auto convert(int64_t number) -> std::string;
}  // namespace roman_numerals

#endif // ROMAN_NUMERALS_H