#if !defined(ACRONYM_H)
#define ACRONYM_H

#include <string>
#include <algorithm>
#include <cctype>

namespace acronym {
  auto acronym(std::string expression) -> std::string;
} // namespace acronym


#endif // ACRONYM_H