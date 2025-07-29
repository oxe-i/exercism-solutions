#pragma once

#include <array>
#include <string>

namespace yacht {
    using dice_t = std::array<int, 5>;
    auto score(const dice_t& roll, std::string category) -> int;
}  // namespace yacht
