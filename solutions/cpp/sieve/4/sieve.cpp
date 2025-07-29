#include "sieve.h"

#include <algorithm> //for_each and remove_if
#include <numeric> //iota

namespace sieve {
    auto primes(int number) -> std::vector<int> {
        auto list_of_primes = std::vector<int>(number - 1);
        
        //all possible prime factors
        std::iota(list_of_primes.begin(), list_of_primes.end(), 2);
        
        std::for_each(
            list_of_primes.cbegin(),
            list_of_primes.cend(),
            [&, count = 1](auto factor) mutable {
                list_of_primes.erase(
                    std::remove_if(
                        list_of_primes.begin() + count, //count signals how many elements have already been iterated
                        list_of_primes.end(),
                        [factor](auto multiple) {
                            return multiple % factor == 0;
                        }
                    ),
                    list_of_primes.end()
                );
                ++count;
            }
        );

        return list_of_primes;
    }
}  // namespace sieve
