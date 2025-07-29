#include "scrabble_score.h"

namespace scrabble_score {
   namespace {
      constexpr auto letter_value = std::array<uint8_t, 26> {
         1,3,3,2,1,4,2,4,1,8,5,1,3,1,1,3,10,1,1,1,1,4,4,8,4,10
      };
   }
   auto score(const std::string& word) -> uint64_t {
       return std::transform_reduce(
                 word.begin(),
                 word.end(),
                 uint64_t{},
                 std::plus{},
                 [&] (unsigned char letter) {
                     auto index = std::tolower(letter) - 'a';
                     return letter_value[index];
                 }
               );
   }
}  // namespace scrabble_score
