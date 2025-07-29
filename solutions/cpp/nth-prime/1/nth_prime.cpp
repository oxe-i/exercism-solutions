#include "nth_prime.h"

namespace nth_prime {

    auto nth(uint64_t n) -> uint64_t {
        if (n == 0) {
            throw(std::domain_error("invalid number"));
        }

        if (n < size) {
            return table_of_primes[n];
        }
        else {
            n -= (size - 1); //how many primes are left
        }

        constexpr auto last_prime_in_table = table_of_primes.back();
        uint64_t nth_prime {};
        
        for (uint64_t potential_prime {last_prime_in_table + 2}; 
            potential_prime < ULLONG_MAX; potential_prime += 2) //primes greater than 2 are odd
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
                --n;
                
                if (not n) {
                    nth_prime = potential_prime;
                    break;
                }
            }
        }

        return nth_prime;
    }

}  // namespace nth_prime
