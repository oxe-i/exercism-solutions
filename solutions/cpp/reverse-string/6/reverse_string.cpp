#include "reverse_string.h"

#include <algorithm>

namespace reverse_string {
    auto reverse_string(std::string text) -> std::string
    {
        std::reverse(text.begin(), text.end());
        return text;
    }
}  // namespace reverse_string
