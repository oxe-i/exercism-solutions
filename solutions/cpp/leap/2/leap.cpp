#include "leap.h"

namespace leap {
   constexpr auto is_divisible(int num, int divisor) -> bool {
       return not (num % divisor);
   }

   constexpr auto divisible_by_4 = [] (int n) {
       return is_divisible(n, 4);
   };

   constexpr auto divisible_by_100 = [] (int n) {
       return is_divisible(n, 100);
   };

   constexpr auto divisible_by_400 = [] (int n) {
       return is_divisible(n, 400);
   };

   auto is_leap_year(int year) -> bool {
       return divisible_by_400(year) ? true :
              divisible_by_100(year) ? false :
              divisible_by_4(year) ? true : false;
   }
}  // namespace leap
