#if !defined(ARMSTRONG_NUMBERS_H)
#define ARMSTRONG_NUMBERS_H

#include <tuple>

namespace armstrong_numbers {
   constexpr auto division(unsigned num, unsigned div)
   {
       return std::pair{num / div, num % div};
   }

   constexpr auto power(unsigned num, unsigned exp)
   {
       if (not exp) return 1UL;
       return exp & 1 ? 
           num * power(num * num, exp >> 1) :
           power(num * num, exp >> 1);
   }

   constexpr auto is_armstrong_number(unsigned number)
   {       
       unsigned num_of_digits {};
       unsigned digits[20] {};

       for (unsigned index {}, num {number}; index < 20 and num > 0; ++index, ++num_of_digits)
           std::tie(num, digits[index]) = division(num, 10);

        unsigned sum {};
               
        for (unsigned index {}; index < num_of_digits; ++index)
            sum += power(digits[index], num_of_digits);

        return number == sum;
   }
}  // namespace armstrong_numbers

#endif // ARMSTRONG_NUMBERS_H