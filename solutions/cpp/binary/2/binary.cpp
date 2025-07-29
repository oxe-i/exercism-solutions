#include "binary.h"

#include <cctype>
#include <cmath>
#include <iostream>

namespace binary {
    auto convert(std::string_view num_string) -> int
    {
        auto number = 0;
        auto multiplier = static_cast<int>(num_string.size() - 1);
        for (const auto digit : num_string)
        {
            if (digit == '1') number += (1 << multiplier);
            else if (digit != '0') return 0;
            multiplier--;
        }
        return number;
    }
}  // namespace binary
