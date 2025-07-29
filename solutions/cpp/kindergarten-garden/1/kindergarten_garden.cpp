#include "kindergarten_garden.h"

namespace kindergarten_garden {
    auto identify_plant(char letter) -> Plants {
        switch (letter) {
            case 'C': return Plants::clover;
            case 'G': return Plants::grass;
            case 'V': return Plants::violets;
            default: return Plants::radishes;
        }
    }

    auto plants(std::string_view cups, const char* child) -> std::array<Plants, 4> {
        const auto start_of_second_row = cups.size() / 2 + 1;
        
        const auto first_row_index = static_cast<unsigned>(*child - 'A') * 2;
        const auto second_row_index = start_of_second_row + first_row_index;
        
        return {identify_plant(cups[first_row_index]), 
                identify_plant(cups[first_row_index + 1]), 
                identify_plant(cups[second_row_index]), 
                identify_plant(cups[second_row_index + 1])};
    }
}  // namespace kindergarten_garden
