#if !defined(SECRET_HANDSHAKE_H)
#define SECRET_HANDSHAKE_H

#include <cstdint>
#include <vector>
#include <string>
#include <array>
#include <algorithm>

namespace secret_handshake {
    auto commands(uint8_t number) -> std::vector<std::string>;
}  // namespace secret_handshake

#endif // SECRET_HANDSHAKE_H
