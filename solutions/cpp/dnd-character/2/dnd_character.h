#pragma once

namespace dnd_character {
    auto modifier( int ability ) -> int;
    auto ability() -> int;

    struct Character {
        int strength = dnd_character::ability();
        int dexterity = dnd_character::ability();
        int constitution = dnd_character::ability();
        int intelligence = dnd_character::ability();
        int wisdom = dnd_character::ability();
        int charisma = dnd_character::ability();
        int hitpoints = 10 + dnd_character::modifier( constitution );
    };
}  // namespace dnd_character
