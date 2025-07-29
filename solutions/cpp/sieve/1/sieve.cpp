#include "sieve.h"

namespace sieve {

   auto primes(int top_bound) -> std::vector<int> {
       auto potential_primes = std::vector<bool>(top_bound + 1, true);

       potential_primes[0] = false;
       potential_primes[1] = false;

       for (auto number {2}; number <= top_bound; ++number) {
           const auto maximum_multiplier = (top_bound / number);

           for (auto multiplier {2}; 
               multiplier <= maximum_multiplier; ++multiplier) {
               const auto index = number * multiplier;
                   
               potential_primes[index] = false;
           }
       }

       auto prime_numbers = std::vector<int>{};

       for (auto index {2}; index < top_bound + 1; ++index) {
           if (potential_primes[index]) {
               prime_numbers.emplace_back(index);
           }
       }

       return prime_numbers;
   }

}  // namespace sieve
