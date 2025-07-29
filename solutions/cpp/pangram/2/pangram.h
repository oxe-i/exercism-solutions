#if !defined(PANGRAM_H)
#define PANGRAM_H

#include <string_view>

namespace pangram {
  auto is_pangram(std::string_view sequence) -> bool;
}  // namespace pangram

#endif // PANGRAM_H