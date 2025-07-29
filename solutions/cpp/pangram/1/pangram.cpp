#include "pangram.h"

namespace pangram {
  auto is_pangram(std::string_view input) -> bool {
      std::bitset<26> check {};
      auto check_index = [] (const char& val) {
          if (val >= 'a' and val <= 'z') {
              return (val - 'a');
          }

          if (val >= 'A' and val <= 'Z') {
              return (val - 'A');
          }

          return -1;
      };

      for (const auto& val : input) {
          if (const auto index = check_index(val); 
              index != -1) {
              check.set(index);
          }
      }

      return check.all();
  }
}  // namespace pangram
