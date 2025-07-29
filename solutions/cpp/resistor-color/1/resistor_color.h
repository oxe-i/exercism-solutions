#pragma once

#include <vector>
#include <string>

namespace resistor_color {
    auto color_code(const char* color) -> int;
    auto colors() -> std::vector<std::string>;
}  // namespace resistor_color
