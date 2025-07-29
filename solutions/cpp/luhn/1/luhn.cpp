#include "luhn.h"

namespace luhn {
    auto format_number(std::string number) -> std::string {
        number.erase(
            std::remove_if(number.begin(), number.end(),
                [](unsigned char character) {
                    return std::isspace(character);
                }),
            number.end()
        );

        return number;
    }

    auto valid(const std::string& number) -> bool {
        auto formatted_number = format_number(number);

        if (formatted_number.size() <= 1 or std::find_if(formatted_number.cbegin(), formatted_number.cend(),
            [](unsigned char character){
                return not std::isdigit(character);
            }) != std::cend(formatted_number)) {
                    return false;
        }

        return std::transform_reduce(formatted_number.rbegin(), formatted_number.rend(), 0ULL, std::plus{},
            [&](auto& value){
                auto numeric_value = value - '0';
                
                if (const auto even_position = (1 + std::distance(
                        &value, &formatted_number[formatted_number.size() - 1])) % 2 == 0; even_position) {
                    numeric_value *= 2;
                    
                    if (numeric_value > 9) {
                        numeric_value -= 9;
                    }
                }
                
                return numeric_value;             
            }) % 10 == 0;
    }
}  // namespace luhn
