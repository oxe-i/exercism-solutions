#pragma once

#include <array>
#include <functional>
#include <numeric>

namespace yacht {
    using dice = std::array<int, 5>;

    auto score(const dice& roll, const char* category_string) -> int;
}  // namespace yacht
