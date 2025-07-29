#include "perfect_numbers.h"

#include <stdexcept>

namespace perfect_numbers 
{
    [[gnu::const]]
    constexpr auto isDivisor(int number, int divisor) -> bool { return number % divisor == 0; }

    [[gnu::const]]
    constexpr auto getDivisorsSum(const int number) -> int
    {
        auto lastDivisor {number};
        auto sum {1};        
        for (auto potentialDivisor {2}; potentialDivisor < lastDivisor; ++potentialDivisor)
        {
            if (isDivisor(number, potentialDivisor))
            {
                lastDivisor = number / potentialDivisor;
                sum += potentialDivisor + lastDivisor * (potentialDivisor != lastDivisor);
            }
        }
        return sum;
    }
    
    auto classify(int number) -> classification
    {
        if (number <= 0) throw std::domain_error("invalid number.");
        if (number == 1) return classification::deficient;

        const auto divisorsSum = getDivisorsSum(number);
        if (number < divisorsSum) return classification::abundant;
        if (number > divisorsSum) return classification::deficient;
        return classification::perfect;
    }
}  // namespace perfect_numbers
