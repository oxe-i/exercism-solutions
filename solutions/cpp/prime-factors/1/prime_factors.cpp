#include "prime_factors.h"

namespace prime_factors {
    auto append(std::vector<int>&& vec, int value) {
        vec.emplace_back(std::move(value));
        return vec;
    }

    auto find_factors(int number) -> std::vector<int> {
        if (number == 1)
            return std::vector<int>{};
    
        for (int factor{2}; factor < number; ++factor) {
            if (number % factor == 0)
                return append(find_factors(number / factor), factor);
        }

        return std::vector<int>{number};
    }

    auto of (int number) -> std::vector<int> {
        auto list_of_factors = find_factors(number);

        std::sort(list_of_factors.begin(), list_of_factors.end());

        return list_of_factors;
    }
}  // namespace prime_factors
