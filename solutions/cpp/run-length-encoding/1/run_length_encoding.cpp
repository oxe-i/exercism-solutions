#include "run_length_encoding.h"

#include <algorithm>
#include <cctype>

namespace run_length_encoding {    
    auto count_equal_letters(std::string::const_iterator begin, std::string::const_iterator end)
    {
        if (begin == end) return std::string{};

        auto next_letter = std::find_if_not(
                                begin,
                                end,
                                [begin](char letter) {return letter == *begin;}
                            );
        auto number_of_ocurrences_for_letter = std::distance(
                                                    begin,
                                                    next_letter
                                                );
        return number_of_ocurrences_for_letter == 1 ?
            std::string{*begin} + count_equal_letters(next_letter, end) :  
            std::to_string(
                number_of_ocurrences_for_letter
            ) + std::string{*begin} + count_equal_letters(next_letter, end);
    }

    auto encode(const std::string& text) -> std::string
    {
        return count_equal_letters(text.cbegin(), text.cend());
    }

    auto insert_letter_n_times(std::string::const_iterator letter, std::size_t number) -> std::string
    {
        return number == 0 ? 
            std::string{} : 
            std::string{*letter} + insert_letter_n_times(letter, number - 1);
    }

    auto unfold_text(std::string::const_iterator begin, std::string::const_iterator end)
    {
        if (begin == end) return std::string{};
        
        if (not std::isdigit(*begin)) 
            return insert_letter_n_times(begin, 1) + unfold_text(begin + 1, end);

        auto letter = std::find_if_not(
                        begin,
                        end,
                        [](auto character) {return std::isdigit(character);}
                    );
        
        std::size_t processed_characters{};
        
        auto number = std::stoi(
                        std::string{begin, letter},
                        &processed_characters
                    );

        return insert_letter_n_times(letter, number) + unfold_text(letter + 1, end);
    }

    auto decode(const std::string& text) -> std::string
    {
        return unfold_text(text.cbegin(), text.cend());
    }
}  // namespace run_length_encoding
