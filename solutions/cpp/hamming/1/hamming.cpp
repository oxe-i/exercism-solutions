#include "hamming.h"

namespace hamming {
    auto compute(const std::string& strand1, const std::string& strand2) -> uint64_t {
        if (strand1.size() != strand2.size()) {
            throw std::domain_error("strands of different sizes.");
        }

        return std::transform_reduce(strand1.cbegin(), strand1.cend(), strand2.cbegin(), 
            uint64_t{}, std::plus{}, [] (auto nucleotide1, auto nucleotide2) {
                return nucleotide1 != nucleotide2;
            });          
    }

}  // namespace hamming
