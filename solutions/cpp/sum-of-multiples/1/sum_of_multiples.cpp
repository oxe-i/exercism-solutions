#include "sum_of_multiples.h"

namespace sum_of_multiples {
    auto to(const std::initializer_list<uint64_t>& magical_items, const uint64_t& level) -> uint64_t {
        auto unique_numbers = std::unordered_set<uint64_t>{};

        return std::accumulate(magical_items.begin(), magical_items.end(), 0ULL, 
            [&] (const auto& acc, const auto& number) {                
                auto sum = uint64_t{};
                
                for (auto multiple = number; multiple < level; multiple += number) {
                    if (not unique_numbers.count(multiple)) {
                        sum += multiple;
                        unique_numbers.insert(multiple);
                    }    
                }

                return acc + sum;
            });
    }
}  // namespace sum_of_multiples
