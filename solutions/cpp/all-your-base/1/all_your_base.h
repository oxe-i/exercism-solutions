#if !defined(ALL_YOUR_BASE_H)
#define ALL_YOUR_BASE_H

#include <vector>
#include <cstdint>

namespace all_your_base {
   auto convert(uint8_t input_base, const std::vector<uint32_t>& number, uint8_t output_base) -> std::vector<uint32_t>;
}  // namespace all_your_base

#endif // ALL_YOUR_BASE_H