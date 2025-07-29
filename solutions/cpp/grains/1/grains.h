#if !defined(GRAINS_H)
#define GRAINS_H

#include <cstdint>
#include <array>
#include <stdexcept>

namespace grains {
    auto square(const uint8_t& input) -> uint64_t;
    auto total() -> uint64_t;
namespace {
    constexpr std::array<uint64_t, 64> board = [] {
        auto array = std::array<uint64_t, 64>{};

        for (uint8_t index {}; index < 64; ++index) {
            array[index] = 1ULL << index;
        }        

        return array;
    }();

    constexpr auto sum = [] {
        uint64_t value {};
        
        for (uint8_t index {}; index < 64; ++index) {
            value |= (1ULL << index);
        }

        return value;
    }();
}
}  // namespace grains

#endif // GRAINS_H