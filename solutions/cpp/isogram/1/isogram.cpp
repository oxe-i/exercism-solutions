#include "isogram.h"

namespace isogram {
    auto is_isogram(const std::string& msg) -> bool {
        auto check = std::bitset<26>{};
        auto letter_index = [] (auto ch) {
            return std::tolower(ch) - 'a';
        };
                
        return std::none_of(
            msg.cbegin(), msg.cend(),
            [&] (unsigned char letter) {
                if (not std::isalpha(letter))
                    return false;
                
                auto index = letter_index(letter);      
                auto not_unique = check.test(index);
                
                check.set(index);
                
                return not_unique;
            });
    }
}  // namespace isogram
