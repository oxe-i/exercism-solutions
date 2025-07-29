#if !defined(PARALLEL_LETTER_FREQUENCY_H)
#define PARALLEL_LETTER_FREQUENCY_H

#include <vector>
#include <string_view>
#include <unordered_map>

namespace parallel_letter_frequency 
{
    using frequency_t = std::unordered_map<char, int>;
    using text_t = std::vector<std::string_view>;

    [[gnu::pure]]
    auto frequency(const text_t&) -> frequency_t;
}

#endif

