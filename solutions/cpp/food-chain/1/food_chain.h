#if !defined(FOOD_CHAIN_H)
#define FOOD_CHAIN_H

#include <cstdint>
#include <string>
#include <array>
#include <numeric>

namespace food_chain {
    auto verse(uint8_t number) -> std::string;
    auto verses(uint8_t start, uint8_t end) -> std::string;
    auto sing() -> std::string;
}  // namespace food_chain

#endif // FOOD_CHAIN_H