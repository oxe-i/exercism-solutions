#if !defined(NTH_PRIME_H)
#define NTH_PRIME_H

#include <stdexcept>
#include <array>
#include <vector>
#include <bitset>

namespace nth_prime {
    constexpr auto maximum_calculable_prime = 200'000;
    constexpr auto maximum_number_of_primes = 17'984;

    constexpr auto table_of_primes = [] {
        //calculated using sieve of Eratosthenes
        
        bool numbers[maximum_calculable_prime] {};

        for (auto number = 2; number < maximum_calculable_prime; ++number)
            numbers[number] = true;
        
        auto list = std::array<unsigned, maximum_number_of_primes>{};
        list[0] = 2;

        for (auto number = 3, index = 1; number < maximum_calculable_prime; number += 2) {
            if (not numbers[number]) continue;
            
            list[index] = number;
            index++;
            for (auto composites = number * 3; composites < maximum_calculable_prime; composites += number)
                numbers[composites] = false;
        }

        return list;
    } ();

    constexpr auto nth(unsigned n) -> unsigned {
        if (n == 0) throw std::domain_error("invalid number, no 0th prime.");
        if (n <= maximum_number_of_primes) return table_of_primes[n - 1];

        return static_cast<unsigned>(-1);
    }
}  // namespace nth_prime

#endif // NTH_PRIME_H