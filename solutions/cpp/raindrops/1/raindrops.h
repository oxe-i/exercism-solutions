#if !defined(RAINDROPS_H)
#define RAINDROPS_H

#include <string>
#include <cstdint>

namespace raindrops {
    template<std::size_t num>
    auto is_divisor_of(const int64_t& number) -> bool;

    auto convert(const int64_t& number) -> std::string;
}  // namespace raindrops

#endif // RAINDROPS_H