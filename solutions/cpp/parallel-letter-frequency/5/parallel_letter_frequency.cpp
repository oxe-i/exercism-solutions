#include "parallel_letter_frequency.h"

#include <cctype>
#include <algorithm>
#include <array>
#include <atomic>
#include <execution>

namespace parallel_letter_frequency
{

auto frequency(const std::vector<std::string_view>& texts) -> std::unordered_map<char, int>
{
    auto hash_table = std::array<std::atomic<int>, 26>{};

    std::for_each(
        std::execution::par, texts.begin(), texts.end(),
        [&hash_table](auto view)
        {
            for (const auto letter : view)
            {
                if (std::isalpha(letter))
                    hash_table[std::tolower(letter) - 'a'].fetch_add(1, std::memory_order_relaxed);
            }
        }
    );

    auto map = std::unordered_map<char, int>{};
    for (auto index = unsigned{}; index < hash_table.size(); ++index)
    {
        const auto elem = hash_table[index].load(std::memory_order_relaxed);
        if (elem) map['a' + index] = elem;
    }

    return map;
}
}
