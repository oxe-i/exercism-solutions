#include "resistor_color_duo.h"

namespace resistor_color_duo {
    constexpr const char* all_colors[10] {"black", "brown", "red", "orange", "yellow", "green", "blue", "violet", "grey", "white"};

    auto compare_colors(const char* first, const char* second) -> bool
    {
        return first[0] == '\0' and second[0] == '\0' ? true :
            first[0] == second[0] and compare_colors(first + 1, second + 1);
    }

    auto index_of_color(const char* color, std::size_t index) -> int
    {
        return index == 10 ? 10 :
            compare_colors(color, all_colors[index]) ? index :
            index_of_color(color, index + 1);
    }

    auto value(std::initializer_list<const char*> colors) -> int
    {
        return 10 * index_of_color(*colors.begin(), 0) + index_of_color(*(colors.begin() + 1), 0);
    }
}  // namespace resistor_color_duo
