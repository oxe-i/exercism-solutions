#if !defined(COLLATZ_CONJECTURE_H)
#define COLLATZ_CONJECTURE_H

#include <stdexcept>

namespace
{
constexpr auto get_to_one(int n, unsigned moves) -> unsigned
{
    if (n == 1) return moves;
    return n % 2 ? get_to_one(3 * n + 1, moves + 1) : get_to_one(n / 2, moves + 1);
}
}

namespace collatz_conjecture 
{
constexpr auto steps(int n) -> unsigned
{
    if (n <= 0) throw std::domain_error("number must be positive integer.");
    return get_to_one(n, 0);
}
}  // namespace collatz_conjecture

#endif // COLLATZ_CONJECTURE_H