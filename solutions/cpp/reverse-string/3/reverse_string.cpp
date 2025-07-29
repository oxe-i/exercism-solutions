#include "reverse_string.h"

namespace reverse_string {
    auto reverse_string(const char* str) -> std::string
    {
        if (str[0] == '\0') return std::string{};
        return reverse_string(str + 1) + std::string{str[0]};
    }
}  // namespace reverse_string
