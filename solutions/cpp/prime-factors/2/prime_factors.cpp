#include "prime_factors.h"

namespace std {
    auto operator+(vector<int>&& fst, vector<int>&& sec) {
        for_each(sec.begin(), sec.end(), [&fst](auto&& value) {fst.emplace_back(std::move(value));});
        return fst;
    }
}

namespace prime_factors {

    auto of(int number) -> std::vector<int> {    
        if (number == 1)
            return std::vector<int>{};

        for (int factor{2}; factor < number; ++factor) {
            if (number % factor == 0)
                return std::vector<int>{factor} + of(number / factor);
        }

        return std::vector<int>{number};
    }
}  // namespace prime_factors
