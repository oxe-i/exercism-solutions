#include "food_chain.h"

namespace food_chain {
    const auto song = std::array<std::string, 8> {
        "I know an old lady who swallowed a fly.\nI don't know why she swallowed the fly. Perhaps she'll die.\n",
        "I know an old lady who swallowed a spider.\nIt wriggled and jiggled and tickled inside her.\nShe swallowed the spider to catch the fly.\nI don't know why she swallowed the fly. Perhaps she'll die.\n",
        "I know an old lady who swallowed a bird.\nHow absurd to swallow a bird!\nShe swallowed the bird to catch the spider that wriggled and jiggled and tickled inside her.\nShe swallowed the spider to catch the fly.\nI don't know why she swallowed the fly. Perhaps she'll die.\n",
        "I know an old lady who swallowed a cat.\nImagine that, to swallow a cat!\nShe swallowed the cat to catch the bird.\nShe swallowed the bird to catch the spider that wriggled and jiggled and tickled inside her.\nShe swallowed the spider to catch the fly.\nI don't know why she swallowed the fly. Perhaps she'll die.\n",
        "I know an old lady who swallowed a dog.\nWhat a hog, to swallow a dog!\nShe swallowed the dog to catch the cat.\nShe swallowed the cat to catch the bird.\nShe swallowed the bird to catch the spider that wriggled and jiggled and tickled inside her.\nShe swallowed the spider to catch the fly.\nI don't know why she swallowed the fly. Perhaps she'll die.\n",
        "I know an old lady who swallowed a goat.\nJust opened her throat and swallowed a goat!\nShe swallowed the goat to catch the dog.\nShe swallowed the dog to catch the cat.\nShe swallowed the cat to catch the bird.\nShe swallowed the bird to catch the spider that wriggled and jiggled and tickled inside her.\nShe swallowed the spider to catch the fly.\nI don't know why she swallowed the fly. Perhaps she'll die.\n",
        "I know an old lady who swallowed a cow.\nI don't know how she swallowed a cow!\nShe swallowed the cow to catch the goat.\nShe swallowed the goat to catch the dog.\nShe swallowed the dog to catch the cat.\nShe swallowed the cat to catch the bird.\nShe swallowed the bird to catch the spider that wriggled and jiggled and tickled inside her.\nShe swallowed the spider to catch the fly.\nI don't know why she swallowed the fly. Perhaps she'll die.\n",
        "I know an old lady who swallowed a horse.\nShe's dead, of course!\n"
    };

    auto verse(uint8_t number) -> std::string {
        return song.at(number - 1);
    }

    auto verses(uint8_t start, uint8_t end) -> std::string {
        return std::accumulate(song.cbegin() + start - 1, song.cbegin() + end, std::string{}, 
            [] (auto acc, auto ch) {
                return acc + ch + "\n";
            });
    }

    auto sing() -> std::string {
        return std::accumulate(song.cbegin(), song.cend(), std::string{},
            [] (auto acc, auto ch) {
                return acc + ch + "\n";
            });
    }
}  // namespace food_chain
