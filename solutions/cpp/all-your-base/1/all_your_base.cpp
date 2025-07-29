#include "all_your_base.h"

#include <cmath>
#include <stdexcept>
#include <algorithm>
#include <numeric>
#include <iostream>

namespace all_your_base {
   auto check_number(uint8_t input_base, const std::vector<uint32_t>& number) {
      return std::all_of(number.begin(), number.end(), [&input_base](auto digit) {return digit < input_base;});
   }

   auto check_base(uint8_t base) {
      return base > 1; 
   }

   auto convert_to_decimal(uint8_t input_base, const std::vector<uint32_t>& number) -> uint64_t {
      return std::accumulate(
               number.begin(),
               number.end(),
               uint64_t{},
               [magnitude = number.size() - 1, input_base] (auto&& acc, auto value) mutable {
                  acc += value * (std::pow(input_base, magnitude));
                  magnitude--;
                  return acc;
               }
            );
   }

   auto to_output_base(uint64_t decimal, uint8_t output_base) -> std::vector<uint32_t> {
      auto number = std::vector<uint32_t>{};

      if (not decimal) {
         return number;
      }

      auto magnitude = static_cast<int64_t>(std::log2(decimal) / std::log2(output_base));

      while (magnitude >= 0) {    
         const auto multiplier = static_cast<uint64_t>(std::pow(output_base, magnitude));                
         
         number.emplace_back(decimal / multiplier);

         decimal %= multiplier;

         magnitude--;      
      }

      return number;
   }

   auto convert(uint8_t input_base, const std::vector<uint32_t>& number, uint8_t output_base) -> std::vector<uint32_t> {
      if (not check_base(input_base) or not check_base(output_base)) 
      {
         throw std::invalid_argument("bases must be greater than 1.");
      }

      if (not check_number(input_base, number))
      {
         throw std::invalid_argument("number digits are invalid for input base.");
      }

      const auto value_in_decimal = convert_to_decimal(input_base, number);

      return to_output_base(value_in_decimal, output_base);    
   }
}  // namespace all_your_base
