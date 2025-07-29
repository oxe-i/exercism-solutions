#if !defined(SUM_OF_MULTIPLES_H)
#define SUM_OF_MULTIPLES_H

#include <cstdint>
#include <unordered_set>
#include <initializer_list>
#include <numeric>

namespace sum_of_multiples {
    auto to(const std::initializer_list<uint64_t>& magical_items, const uint64_t& level) -> uint64_t;
}  // namespace sum_of_multiples

#endif // SUM_OF_MULTIPLES_H