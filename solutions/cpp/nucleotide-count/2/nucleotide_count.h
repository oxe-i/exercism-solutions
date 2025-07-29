#if !defined(NUCLEOTIDE_COUNT_H)
#define NUCLEOTIDE_COUNT_H

#include <string>
#include <map>

namespace nucleotide_count {
   auto count(const std::string& dna) -> std::map<char, int>;
}  // namespace nucleotide_count

#endif // NUCLEOTIDE_COUNT_H