#pragma once

#include <string_view>
#include <string>

namespace pig_latin {
    auto translate(std::string_view word) -> std::string;
}  // namespace pig_latin
