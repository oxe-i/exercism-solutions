#include "sum_of_multiples.h"

#include <unordered_set>
#include <numeric>

namespace sum_of_multiples {
    auto to(std::initializer_list<int> base_values, int level) -> int
    {
        auto unique_multiples = std::unordered_set<int>{};
        for (const int value : base_values)
        {
            int multiple = value;
            while (multiple < level)
            {
                unique_multiples.insert(multiple);
                multiple += value;
            }
        }
        return std::accumulate(unique_multiples.begin(), unique_multiples.end(), 0);
    }
}  // namespace sum_of_multiples
