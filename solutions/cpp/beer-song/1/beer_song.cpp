#include "beer_song.h"

namespace beer_song {
    namespace {
        const auto verse_table = [] {
            auto array = std::array<std::string, 100>{};

            array[1] = "1 bottle of beer on the wall, 1 bottle of beer.\n";
            array[1] += "Take it down and pass it around, no more bottles of beer on the wall.\n";

            array[0] = "No more bottles of beer on the wall, no more bottles of beer.\n";
            array[0] += "Go to the store and buy some more, 99 bottles of beer on the wall.\n";
           
            for (int index {2}; index < 100; ++index) {
                const auto number = std::to_string(index);
                const auto one_less = std::to_string(index - 1);

                array[index] = number + " bottles of beer on the wall, " + number + " bottles of beer.\n";
                array[index] += "Take one down and pass it around, " + one_less + " bottle" + (index > 2 ? "s " : " ") + "of beer on the wall.\n";
            }

            return array;
        }();
    }

    auto verse(uint8_t number) -> std::string {
        return verse_table[number];
    }

    auto sing(uint8_t start, uint8_t end) -> std::string {
        auto song = std::string{};

        for (auto index = start ; index > end; --index) {
            song += verse_table[index];
            song += '\n';
        }

        
        song += verse_table[end];

        return song;
    }

    auto sing(uint8_t start) -> std::string {
        auto song = std::string{};

        for (int index = start; index > 0; --index) {
            song += verse_table[index];
            song += '\n';
        }

        song += verse_table[0];

        return song;
    }
}  // namespace beer_song
