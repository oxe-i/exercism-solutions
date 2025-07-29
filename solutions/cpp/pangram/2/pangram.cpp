#include "pangram.h"

#include <bitset>
#include <cctype>

namespace pangram {
  inline auto check_index(char val) {
     return std::isalpha(val) ? 
         std::tolower(val) - 'a' : -1;
  }

  auto is_pangram(std::string_view sequence) -> bool {
      std::bitset<26> check {};
      
      for (const auto val : sequence) {
          if (const auto index = check_index(val); index != -1)
              check.set(index);
      }

      return check.all();
  }
}  // namespace pangram
