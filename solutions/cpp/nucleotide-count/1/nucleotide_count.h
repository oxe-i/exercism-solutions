#if !defined(NUCLEOTIDE_COUNT_H)
#define NUCLEOTIDE_COUNT_H

#include <stdexcept>
#include <string>
#include <map>

namespace nucleotide_count {
    auto count(const std::string& DNA) -> std::map<char, int>;
}  // namespace nucleotide_count

#endif // NUCLEOTIDE_COUNT_H