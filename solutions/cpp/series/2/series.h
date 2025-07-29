#if !defined(SERIES_H)
#define SERIES_H

#include <string_view>
#include <string>
#include <vector>

namespace series {
    auto slice(std::string_view, int) -> std::vector<std::string>;
}  // namespace series

#endif // SERIES_H