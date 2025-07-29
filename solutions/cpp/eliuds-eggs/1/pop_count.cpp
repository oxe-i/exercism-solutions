#include "pop_count.h"

namespace chicken_coop {
   auto positions_to_quantity(uint64_t number) -> uint8_t {
       return not number ? 0 :
           (number & 1) + positions_to_quantity(number >> 1);
   }
}  // namespace chicken_coop
