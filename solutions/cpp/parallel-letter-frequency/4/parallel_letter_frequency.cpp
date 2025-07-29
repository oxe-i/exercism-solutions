#include "parallel_letter_frequency.h"

#include <cctype>
#include <algorithm>
#include <execution>

namespace parallel_letter_frequency
{
auto frequency(const text_t& text) -> map_t
{
    return std::transform_reduce(
        std::execution::par_unseq, text.begin(), text.end(), map_t{},
        [](map_t map1, map_t map2)
        {
            map2.merge(map1);
            for (auto&& [letter, frequency] : map1)
                map2[letter] += frequency;
            return map2;
        },
        [](word_t word)
        {
            auto map = map_t{};
            for (char letter : word)
                if (std::isalpha(letter)) 
                    map[std::tolower(letter)]++;
            return map;
        }
    );
}
}
