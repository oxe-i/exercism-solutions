#include "resistor_color.h"

#include <algorithm>

namespace resistor_color {
    constexpr const char* all_colors[10] {"black", "brown", "red", "orange", "yellow", "green", "blue", "violet", "grey", "white"};

    auto compare_colors(const char* first, const char* second) -> bool
    {
        return first[0] == '\0' and second[0] == '\0' ? true :
            first[0] == second[0] and compare_colors(first + 1, second + 1);
    }

    auto check_index_of_color(const char* color, std::size_t index) -> int
    {
        return index == 10 ? 10 :
            compare_colors(color, all_colors[index]) ? index :
            check_index_of_color(color, index + 1);
    }

    auto color_code(const char* color) -> int
    {
        return check_index_of_color(color, 0);
    }

    auto colors() -> std::vector<std::string>
    {
        static auto vector_of_colors = []
        {
            auto vector = std::vector<std::string>(10);
            std::copy(std::begin(all_colors), std::end(all_colors), vector.begin());
            return vector;
        }();
        
        return vector_of_colors;
    }
}  // namespace resistor_color
