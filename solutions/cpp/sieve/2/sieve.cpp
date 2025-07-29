#include "sieve.h"

namespace sieve {
    //C-style solution with dynamic array
    auto primes(const std::size_t number) -> std::vector<int> {
        if (number <= 1)
            return std::vector<int>{};

        struct memo_buffer {
            bool* buffer;
           
            memo_buffer(std::size_t size) 
            {
                buffer = new bool[size];
            }
            
            ~memo_buffer() {
                delete[] buffer;
            }
            
            auto& operator[](std::size_t index) {
                return buffer[index];
            }
        };

        memo_buffer memo(number + 1);
        
        auto count_of_primes = std::vector<int>{};

        for (std::size_t index = 0; index <= number; ++index)
            memo[index] = false;

        for (std::size_t factor = 2; factor <= number; ++factor) {
            if (not memo[factor])
                count_of_primes.emplace_back(factor);
            
            for (std::size_t multiple = factor * 2; multiple <= number; multiple += factor)
                memo[multiple] = true;
        }
        
        return count_of_primes;
    }
}  // namespace sieve
