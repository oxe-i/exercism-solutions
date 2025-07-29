#pragma once

#include <array>
#include <string_view>

namespace kindergarten_garden {
    enum class Plants {
        clover,
        grass,
        violets,
        radishes
    };

    auto plants(std::string_view cups, const char* child) -> std::array<Plants, 4>;
}  // namespace kindergarten_garden
