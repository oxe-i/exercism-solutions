#include "nucleotide_count.h"

namespace nucleotide_count {
    auto count(const std::string& DNA) -> std::map<char, int> {
        auto nucleotide_count = std::map<char, int>{{'A', 0}, {'C', 0}, {'G', 0}, {'T', 0}};
        
        for (const auto& nucleotide : DNA) {
            if (nucleotide == 'A' or nucleotide == 'C' or nucleotide == 'G' or nucleotide == 'T') {
                ++nucleotide_count[nucleotide];
            }
            else {
                throw std::invalid_argument{"invalid character"};
            }
        }

        return nucleotide_count;
    }
}  // namespace nucleotide_count
