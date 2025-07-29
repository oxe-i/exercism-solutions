#if !defined(PARALLEL_LETTER_FREQUENCY_H)
#define PARALLEL_LETTER_FREQUENCY_H

#include <vector>
#include <string_view>
#include <unordered_map>

namespace parallel_letter_frequency 
{
    using map_t = std::unordered_map<char, int>;
    using word_t = std::string_view;
    using text_t = std::vector<word_t>;
    
    [[gnu::pure]]
    auto frequency(const text_t&) -> map_t;
}

#endif

