#include "hamming.h"

#include <stdexcept>

namespace hamming {
  //C-style answer with C++ exception and a bit of idiom
  auto compute(const char* strandA, const char* strandB) -> uint64_t {
      uint64_t index{}, count{};
      
      while (true) {
          if ((strandA[index] == '\0') and (strandB[index] == '\0')) {
              return count;
          }
          
          if ((strandA[index] == '\0') xor (strandB[index] == '\0')) {
              throw std::domain_error("different lengths.");
          }

          count += (strandA[index] != strandB[index]);
          index++;
      }

      return count;
  }
}  // namespace hamming
