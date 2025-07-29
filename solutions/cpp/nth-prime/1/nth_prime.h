#if !defined(NTH_PRIME_H)
#define NTH_PRIME_H

#include <cstdint>
#include <stdexcept>
#include <array>
#include <algorithm>
#include <limits.h>
#include <cmath>

namespace nth_prime {

    auto nth(uint64_t number) -> uint64_t;

    namespace {
        constexpr auto size {10'000};
        constexpr std::array<uint64_t, size> table_of_primes = [] {
            std::array<uint64_t, size> table {};
            
            table[1] = 2;

            for (uint64_t potential_prime {3}, table_index {2}; 
                table_index < size and potential_prime < ULLONG_MAX; potential_prime += 2) 
                //primes greater than 2 are odd
            {    
                bool is_prime {true};

                for (uint64_t potential_divisor {3}; potential_divisor <= potential_prime / potential_divisor;
                    potential_divisor += 2) //odd numbers can't be divided by even numbers and a divisor must be less or equal than the square root
                {
                    if (potential_prime % potential_divisor == 0) {
                        is_prime = false;
                        break;
                    }
                }

                if (is_prime) {
                    table[table_index] = potential_prime;
                    ++table_index;
                }
            }

            return table;
        }();
    }
}  // namespace nth_prime

#endif // NTH_PRIME_H