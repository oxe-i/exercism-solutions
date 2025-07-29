#if !defined(PARALLEL_LETTER_FREQUENCY_H)
#define PARALLEL_LETTER_FREQUENCY_H

#include <vector>
#include <string_view>
#include <unordered_map>

namespace parallel_letter_frequency 
{
    [[gnu::pure]]
    auto frequency(const std::vector<std::string_view>&) -> std::unordered_map<char, int>;
}

#endif

