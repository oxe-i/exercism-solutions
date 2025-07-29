#if !defined(ACRONYM_H)
#define ACRONYM_H

#include <string_view>
#include <numeric>
#include <cctype>
#include <string>

namespace acronym {
    struct String 
    {
        char string[20];
        unsigned size;
        
        operator std::string() {return std::string{string};}
    };

    template <typename Char>
    constexpr auto add(String& str, Char ch) 
    {
        str.string[str.size] = static_cast<char>(ch);
        str.size++;
    }

    constexpr auto is_separator(char letter)
    {
        return std::isspace(letter) or letter == '-';
    }

    [[gnu :: const]]
    constexpr auto acronym(std::string_view text) -> String 
    {
        auto answer = String{};
        auto separator = true;
        
        for (const auto letter : text) 
        {
            if (separator and std::isalpha(letter)) 
            {
                separator = false;
                add(answer, std::toupper(letter));
            }
            
            if (not separator and is_separator(letter))
                separator = true;
        }

        return answer;
    }
}  // namespace acronym

#endif // ACRONYM_H