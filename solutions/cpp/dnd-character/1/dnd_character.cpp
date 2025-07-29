#include "dnd_character.h"

#include <random>
#include <numeric>
#include <algorithm>

namespace dnd_character {
    auto ability() -> int {
        std::mt19937 mt{std::random_device{}()};
        std::uniform_int_distribution<int> dice(1, 6);

        const int rolls[4] {dice(mt), dice(mt), dice(mt), dice(mt)};
        
        return std::accumulate(std::begin(rolls), std::end(rolls), 0) - 
            *std::min_element(std::begin(rolls), std::end(rolls));
    }
}  // namespace dnd_character
