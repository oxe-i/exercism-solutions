#if !defined(SIEVE_H)
#define SIEVE_H

#include <vector>
#include <cstddef>

namespace sieve {
    auto primes(const std::size_t number) -> std::vector<int>;
}  // namespace sieve

#endif // SIEVE_H