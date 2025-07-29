#if !defined(ATBASH_CIPHER_H)
#define ATBASH_CIPHER_H

#include <string>
#include <array>
#include <algorithm>
#include <cctype>

namespace atbash_cipher {
    constexpr std::array<char, 26> encoded_alphabet = [] {
        std::array<char, 26> array{};
        
        for (auto index {0}; index < 26; ++index) {
            array[index] = 'z' - index;
        }

        return array;
    }();

    auto find_letter(unsigned char letter) -> char;
    auto remove_whitespace_and_punctuation(std::string message) -> std::string;

    auto encode(const std::string& message) -> std::string;
    auto decode(const std::string& message) -> std::string;
}  // namespace atbash_cipher

#endif // ATBASH_CIPHER_H