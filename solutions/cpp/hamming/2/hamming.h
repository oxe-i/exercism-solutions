#if !defined(HAMMING_H)
#define HAMMING_H

#include <cstdint>

namespace hamming {
  auto compute(const char* strandA, const char* strandB) -> uint64_t;
}  // namespace hamming

#endif // HAMMING_H