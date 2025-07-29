#include "prime_factors.h"

#include <algorithm>

namespace prime_factors {

    auto operator+(std::vector<int>&& fst, std::vector<int>&& sec) {
        std::move(sec.begin(), sec.end(), std::back_inserter(fst));
        return fst;
    }

    auto of(int number) -> std::vector<int> {    
        if (number == 1)
            return std::vector<int>{};

        for (int factor{2}; factor * factor <= number; ++factor) {
            if (number % factor == 0)
                return std::vector<int>{factor} + of(number / factor);
        }

        return std::vector<int>{number};
    }
}  // namespace prime_factors
