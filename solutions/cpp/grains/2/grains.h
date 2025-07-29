#if !defined(GRAINS_H)
#define GRAINS_H

#include <cstdint>

namespace grains {
   constexpr auto square(uint8_t number) -> uint64_t
   {
       return 1ULL << (number - 1);
   }

   constexpr auto total() -> uint64_t
   {
       return (square(64) << 1) - 1;
   }
}  // namespace grains

#endif // GRAINS_H