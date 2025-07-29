#include "nucleotide_count.h"

#include <stdexcept>
#include <numeric>

namespace nucleotide_count {
   auto is_valid_nucleotide(char nucleotide) {
       switch (nucleotide) {
           case 'A':
           case 'C':
           case 'T':
           case 'G':
             return true;
           default:
             return false;
       }
   }
   auto count(const std::string& dna) -> std::map<char, int> {
       return std::accumulate(
          dna.begin(),
          dna.end(),
          std::map<char, int>{{'A', 0}, {'C', 0}, {'T', 0}, {'G', 0}},
          [&](auto&& map, char nucleotide) {
              if (not is_valid_nucleotide(nucleotide))
                  throw std::invalid_argument("invalid nucleotide.");
              map[nucleotide]++;
              return map;
          }
       );
   }
}  // namespace nucleotide_count
