#include "armstrong_numbers.h"

namespace armstrong_numbers {
   auto is_armstrong_number(uint64_t number) -> bool {
       const auto number_as_string {std::to_string(number)};
       return number ==
           std::accumulate(
             number_as_string.cbegin(),
             number_as_string.cend(),
             uint64_t{},
             [magnitude = number_as_string.size()]
             (auto accumulator, auto digit) {
                 const uint64_t value = std::pow(
                    digit - '0', magnitude
                 );
         
                 return accumulator + value;
             }
           );
   }
}  // namespace armstrong_numbers
