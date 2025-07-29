#include "pop_count.h"

namespace chicken_coop {
   auto positions_to_quantity(uint64_t num) -> uint8_t {
       return num ? (num & 1) + positions_to_quantity(num >> 1) : 0;
   }
}  // namespace chicken_coop
