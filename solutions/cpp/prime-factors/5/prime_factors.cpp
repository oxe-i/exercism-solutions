#include "prime_factors.h"

#include <algorithm>

namespace prime_factors {
    auto push_into(std::vector<int> vec, int number) {
        vec.emplace_back(number);
        return vec;
    }

    auto helper(int number) -> std::vector<int> {
        for (int factor {2}; factor * factor <= number; ++factor)
            if (number % factor == 0) return push_into(helper(number / factor), factor);      
        return {number};
    }

    auto of(int number) -> std::vector<int> {
        if (number <= 1) return {};

        auto answer = helper(number);
        std::reverse(answer.begin(), answer.end());
        
        return answer;
    }
}  // namespace prime_factors
