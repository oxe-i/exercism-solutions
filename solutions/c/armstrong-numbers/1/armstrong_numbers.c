#include "armstrong_numbers.h"

unsigned power(unsigned x, unsigned exp)
{
    if (!exp) return 1;
    return exp & 1U ? 
        x * power(x * x, exp >> 1U) :
        power(x * x, exp >> 1U);
}

bool is_armstrong_number(unsigned candidate)
{
    unsigned digits[32];
    unsigned number = candidate;
    unsigned size = 0;
    
    while (number)
    {
        digits[size++] = number % 10;
        number /= 10;
    }

    unsigned sum = 0;
    for (unsigned index = 0; index < size; ++index)
    {
        sum += power(digits[index], size);
    }

    return sum == candidate;
}
