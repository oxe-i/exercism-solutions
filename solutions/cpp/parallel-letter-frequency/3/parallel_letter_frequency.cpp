#include "parallel_letter_frequency.h"

#include <algorithm>
#include <execution>

namespace parallel_letter_frequency
{

auto frequency(const text_t& text) -> frequency_t
{
    auto map = frequency_t{};
    std::for_each(
        std::execution::par, text.begin(), text.end(),
        [&map] (auto word)
        {
            std::for_each(
                std::execution::par, word.begin(), word.end(),
                [&map] (auto letter)
                {
                    if (std::isalpha(letter))
                        map[std::tolower(letter)]++;
                }
            );
        }
    );
    return map;
}

}