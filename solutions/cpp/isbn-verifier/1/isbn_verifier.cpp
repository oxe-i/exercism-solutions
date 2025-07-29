#include "isbn_verifier.h"

namespace isbn_verifier {
    auto format_number(std::string isbn) -> std::string {
        isbn.erase(
            std::remove_if(isbn.begin(), isbn.end(),
                [](unsigned char character){
                    return character == '-';
                }),
            isbn.end()
        );

        return isbn;
    }

    auto is_valid(const std::string& isbn) -> bool {
        auto formatted_isbn = format_number(isbn);

        if (formatted_isbn.size() != 10) {
            return false;
        } 
        if (std::find_if(formatted_isbn.begin(), formatted_isbn.end(),
                [](unsigned char character){
                    return not std::isdigit(character);
                }) < formatted_isbn.end() - 1) {
            return false;
        }
        if (not (std::isdigit(formatted_isbn.back()) or formatted_isbn.back() == 'X')) {
               return false;         
        }

        return std::transform_reduce(formatted_isbn.begin(), formatted_isbn.end(), 0ULL, std::plus{},
            [&](auto& digit) {
                auto numeric_value = std::isdigit(digit) ? digit - '0' : 10;
                auto multiplier = 10 - std::distance(&formatted_isbn[0], &digit);
                
                return numeric_value * multiplier;
            }) % 11 == 0;
    }
}  // namespace isbn_verifier