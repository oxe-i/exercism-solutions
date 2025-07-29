#if !defined(PARALLEL_LETTER_FREQUENCY_H)
#define PARALLEL_LETTER_FREQUENCY_H

#include <vector>
#include <string_view>
#include <unordered_map>
#include <cctype>

namespace parallel_letter_frequency {
    using text_t = std::vector<std::string_view>;
    using frequency_t = std::unordered_map<char, int>;

    [[gnu::pure]]
    auto frequency(const text_t&) -> frequency_t;
}

#endif

