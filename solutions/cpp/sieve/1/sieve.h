#if !defined(SIEVE_H)
#define SIEVE_H

#include <vector>

namespace sieve {
   auto primes(int top_bound) -> std::vector<int>;
}  // namespace sieve

#endif // SIEVE_H