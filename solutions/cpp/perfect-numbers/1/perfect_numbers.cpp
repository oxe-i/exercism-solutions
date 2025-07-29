#include "perfect_numbers.h"

namespace perfect_numbers {
   auto classify(const int64_t number) -> uint8_t {
       if (number < 1) {
           throw std::domain_error("number less than 1");
       }

       if (number == 1) {
           return perfect_numbers::deficient;
       }
       
       auto sum_of_divisors = int64_t{1};
       const auto root = std::floor(std::sqrt(number));

       for (uint64_t divisor {2}; divisor <= root; ++divisor) {
           if (not (number % divisor)) {
               sum_of_divisors += divisor;
               if (const auto other_divisor = number / divisor; 
                   other_divisor != divisor) {
                   sum_of_divisors += other_divisor;
               }
           }
       }

       if (sum_of_divisors > number) {
           return perfect_numbers::abundant;
       }
       else if (sum_of_divisors == number) {
           return perfect_numbers::perfect;
       }

       return perfect_numbers::deficient;
   }
}  // namespace perfect_numbers
