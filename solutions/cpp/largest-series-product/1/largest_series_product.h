#if !defined(LARGEST_SERIES_PRODUCT_H)
#define LARGEST_SERIES_PRODUCT_H

#include <string>
#include <cstdint>
#include <stdexcept>
#include <numeric>
#include <algorithm>
#include <string_view>

namespace largest_series_product {
    auto largest_product(const std::string& input, int64_t span) -> uint64_t;
} // largest_series_product

#endif // LARGEST_SERIES_PRODUCT_H