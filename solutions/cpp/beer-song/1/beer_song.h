#if !defined(BEER_SONG_H)
#define BEER_SONG_H

#include <cstdint>
#include <string>
#include <array>

namespace beer_song {
    auto verse(uint8_t number) -> std::string;
    auto sing(uint8_t start, uint8_t end) -> std::string;
    auto sing(uint8_t start) -> std::string;
}  // namespace beer_song

#endif // BEER_SONG_H