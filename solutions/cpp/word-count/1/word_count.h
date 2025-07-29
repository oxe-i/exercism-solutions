#if !defined(WORD_COUNT_H)
#define WORD_COUNT_H

#include <string>
#include <map>
#include <cctype>
#include <numeric>
#include <algorithm>

namespace word_count {
    auto words(std::string subtitle) -> std::map<std::string, int>;
}  // namespace word_count

#endif // WORD_COUNT_H
