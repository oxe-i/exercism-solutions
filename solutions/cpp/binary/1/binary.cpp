#include "binary.h"

namespace binary {
    auto convert(const std::string& bit_string) -> uint64_t {
        if (std::any_of(std::begin(bit_string), std::end(bit_string), [](auto bit){return bit < '0' or bit > '1';}))
            return 0;

        return std::bitset<64>{bit_string}.to_ullong();
    }
}  // namespace binary
