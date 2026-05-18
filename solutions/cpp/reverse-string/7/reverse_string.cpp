#include "reverse_string.h"

namespace reverse_string {
    auto reverse_string(std::string text) -> std::string
    {
        size_t i {}, j {text.size()};
        while (i < j) {
            const auto c = text[i];
            text[i++] = text[--j];
            text[j] = c;
        }
        return text;
    }
}  // namespace reverse_string
