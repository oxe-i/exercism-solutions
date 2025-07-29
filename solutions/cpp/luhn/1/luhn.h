#if !defined(LUHN_H)
#define LUHN_H

#include <string>
#include <cctype>
#include <algorithm>
#include <numeric>
#include <iterator>

namespace luhn {
    auto valid(const std::string& number) -> bool;
}  // namespace luhn

#endif // LUHN_H