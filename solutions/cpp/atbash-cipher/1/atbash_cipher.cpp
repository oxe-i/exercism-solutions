#include "atbash_cipher.h"

namespace atbash_cipher {
    auto find_letter(unsigned char letter) -> char {       
        if (letter >= '1' and letter <= '9') {
            return letter;
        }
        
        const auto index = std::tolower(letter) - 'a';        
        return encoded_alphabet.at(index);
    }

    auto remove_whitespace_and_punctuation(std::string message) -> std::string {
        auto end_of_valid_char = std::remove_if(message.begin(), message.end(),
            [](unsigned char letter) {
                return std::isspace(letter) or
                    std::ispunct(letter);
            });

        auto formatted_message = std::string{};

        std::move(message.begin(), end_of_valid_char, 
            std::back_inserter(formatted_message));

        return formatted_message;
    }

    auto encode(const std::string& message) -> std::string {        
        auto encrypted_message = remove_whitespace_and_punctuation(message);
        
        std::transform(encrypted_message.cbegin(), encrypted_message.cend(),
            encrypted_message.begin(), find_letter);

        if (auto size = encrypted_message.size(); size > 5) {
            auto index = std::size_t{5};
            
            while (index < size) {
                encrypted_message.insert(index, " ");
                index += 6;
                size = encrypted_message.size();
            }
        }
        
        return encrypted_message;
    }

    auto decode(const std::string& message) -> std::string {
        auto decrypted_message = remove_whitespace_and_punctuation(message);

        std::transform(decrypted_message.cbegin(), decrypted_message.cend(),
            decrypted_message.begin(), find_letter);
        
        return decrypted_message;
    }
}  // namespace atbash_cipher
