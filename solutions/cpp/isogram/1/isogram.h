#if !defined(ISOGRAM_H)
#define ISOGRAM_H

#include <bitset>
#include <string>
#include <algorithm>
#include <cctype>

namespace isogram {
    auto is_isogram(const std::string& msg) -> bool;
}  // namespace isogram

#endif // ISOGRAM_H