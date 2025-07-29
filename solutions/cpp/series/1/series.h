#if !defined(SERIES_H)
#define SERIES_H

#include <stdexcept>
#include <cstdint>
#include <string>
#include <vector>
#include <algorithm>

namespace series {
    auto slice(const std::string& sequence, int64_t number) -> std::vector<std::string>;
}  // namespace series

#endif // SERIES_H