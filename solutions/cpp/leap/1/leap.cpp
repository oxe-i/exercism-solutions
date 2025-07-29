#include "leap.h"

namespace leap {
   auto is_leap_year(int year) -> bool {
       return not (year % 400) or (not (year % 4) and (year % 100));
   }
}  // namespace leap
