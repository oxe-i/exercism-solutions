#include "sieve.h"

#include <algorithm>

//a very convoluted solution to motivate study of lambdas and lambda recursion
namespace sieve {
    auto operator+(std::vector<int>&& fst, std::vector<int>&& sec) {
        std::move(sec.begin(), sec.end(), std::back_inserter(fst));
        return fst;
    }

    auto primes(int number) -> std::vector<int> {
        auto memo = std::vector<bool>(number + 1, false);

        auto find_primes = [&memo, max = number](auto&& find_primes, int factor) {
            if (factor > max)
                return std::vector<int>{};

            auto fill_memo = [&memo, max, factor](auto&& fill_memo, int multiple) {
                if (multiple > max)
                    return;
    
                memo[multiple] = true;
    
                fill_memo(fill_memo, multiple + factor);
            };
            
            if (not memo[factor])
                fill_memo(fill_memo, factor << 1);

            return not memo[factor] ? std::vector<int>{factor} + find_primes(find_primes, factor + 1) : 
                find_primes(find_primes, factor + 1);
        };

       return find_primes(find_primes, 2);
    }
}  // namespace sieve
