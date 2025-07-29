#if !defined(SAY_H)
#define SAY_H

#include <string>
#include <cstdint>

namespace say {
    auto in_english(int64_t number) -> std::string;
}  // namespace say

#endif // SAY_H