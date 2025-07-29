#pragma once

#include <initializer_list>

namespace resistor_color_duo {
    auto value(std::initializer_list<const char*> colors) -> int;
}  // namespace resistor_color_duo
