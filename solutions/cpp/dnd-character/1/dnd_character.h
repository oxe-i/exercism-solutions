#pragma once

#include <functional>

namespace dnd_character {
    constexpr auto modifier(int ability) -> int {
        return (ability - 10) >> 1;
    }

    auto ability() -> int;

    struct Character {
        int strength = std::invoke(dnd_character::ability);
        int dexterity = std::invoke(dnd_character::ability);
        int constitution = std::invoke(dnd_character::ability);
        int intelligence = std::invoke(dnd_character::ability);
        int wisdom = std::invoke(dnd_character::ability);
        int charisma = std::invoke(dnd_character::ability);
        int hitpoints = 10 + std::invoke(dnd_character::modifier, constitution);
    };
}  // namespace dnd_character
