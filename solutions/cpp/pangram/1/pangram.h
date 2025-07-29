#if !defined(PANGRAM_H)
#define PANGRAM_H

#include <bitset>

namespace pangram {

  auto is_pangram(std::string_view input) -> bool;

}  // namespace pangram

#endif // PANGRAM_H