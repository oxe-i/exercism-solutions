#pragma once

#include <string>

namespace run_length_encoding {
    auto encode(const std::string& text) -> std::string;
    auto decode(const std::string& text) -> std::string;
}  // namespace run_length_encoding
