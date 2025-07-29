#include "binary_search.h"

#include <stdexcept>

namespace binary_search {

using position = std::vector<int>::const_iterator;

auto check_space(position low, position high, int target)
{
    if (low > high) return static_cast<position>(nullptr);
    const auto mid = low + std::distance(low, high) / 2;
    if (*mid == target) return mid;
    if (*mid > target) return check_space(low, mid - 1, target);
    return check_space(mid + 1, high, target);
}

auto find(const std::vector<int>& data, int target) -> std::size_t
{
    if (data.empty()) throw std::domain_error("can't search on an empty list.");
    const auto target_position = check_space(data.begin(), data.end() - 1, target);  
    if (target_position == static_cast<position>(nullptr)) throw std::domain_error("value not found.");
    return std::distance(data.begin(), target_position);
}

}  // namespace binary_search
