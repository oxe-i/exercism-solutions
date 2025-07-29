#pragma once

#include <string>

namespace rotational_cipher {
    auto rotate(const char* plain, int rotation) -> std::string;
}  // namespace rotational_cipher
