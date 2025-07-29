#include "diamond.h"

#include <cctype>
#include <algorithm>

namespace diamond {
    auto add_spaces(std::size_t number) -> std::string
    {
        return number ? std::string{" "} + add_spaces(number - 1) : std::string{};
    }
    auto add_lines(char initial_letter, char current_letter) -> std::vector<std::string>
    {
        auto space = add_spaces(initial_letter - current_letter);
        
        if (current_letter == 'A') return std::vector{space + 'A' + space};

        auto lines = add_lines(initial_letter, current_letter - 1);
        
        lines.emplace_back(
            space + 
            current_letter + 
            add_spaces(2 * (current_letter - 'A') - 1) +
            current_letter +
            space
        );
        
        return lines;
    }

    auto rows(char letter) -> std::vector<std::string>
    {
        auto upper_letter = std::toupper(letter);
        
        const auto first_lines = add_lines(upper_letter, upper_letter);
        auto all_lines = std::vector<std::string>{first_lines};

        all_lines.resize(2 * (first_lines.size() - 1) + 1);
        
        std::reverse_copy
        (
            first_lines.cbegin(), 
            first_lines.cend() - 1, 
            all_lines.begin() + first_lines.size()
        );

        return all_lines;
    }
}  // namespace diamond
