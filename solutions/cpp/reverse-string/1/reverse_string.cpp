#include "reverse_string.h"

namespace reverse_string {
   auto reverse_string(std::string input) -> std::string {
       std::reverse(input.begin(), input.end());
       return input;
   }
}  // namespace reverse_string
