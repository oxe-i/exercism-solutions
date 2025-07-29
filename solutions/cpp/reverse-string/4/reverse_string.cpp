#include "reverse_string.h"

namespace reverse_string {
    auto reverse_string(const char* sequence) -> std::string
    {
        return *sequence == '\0' ?
            std::string{} :
            reverse_string(sequence + 1) + *sequence;
    }
}  // namespace reverse_string
