#if !defined(SIEVE_H)
#define SIEVE_H

#include <vector>

namespace sieve {
    auto primes(int number) -> std::vector<int>;
}  // namespace sieve

#endif // SIEVE_H