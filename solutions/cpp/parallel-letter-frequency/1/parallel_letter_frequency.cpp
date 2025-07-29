#include "parallel_letter_frequency.h"

#include <cctype>
#include <algorithm>
#include <execution>

namespace parallel_letter_frequency
{
auto frequency(const text_t& text) -> Frequency
{
    auto map = Frequency{};
    std::for_each(
           std::execution::par, 
           text.begin(), 
           text.end(),
           [&map](std::string_view word) 
           {
               std::for_each(
                   std::execution::par,
                   word.begin(), 
                   word.end(),
                   [&map] (const char letter)
                   {
                        if (std::isalpha(letter))  
                           map[std::tolower(letter)]++;
                   });
           });
    return map;
}
}
