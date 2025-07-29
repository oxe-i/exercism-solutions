#include "atbash_cipher.h"

namespace atbash_cipher {
    auto find_letter(unsigned char letter) -> char {       
        if (std::isdigit(letter)) {
            return letter;
        }
        
        const auto index = std::tolower(letter) - 'a'; 
        
        return encoded_alphabet.at(index);
    }

    auto remove_whitespace_and_punctuation(std::string message) -> std::string {
        message.erase(
            std::remove_if(message.begin(), message.end(),
            [](unsigned char letter) {
                return std::isspace(letter) or std::ispunct(letter);
            }),
            message.end()
        );

        return message;
    }

    auto encode(const std::string& message) -> std::string {       
        auto encrypted_message = remove_whitespace_and_punctuation(message);

        std::transform(encrypted_message.cbegin(), encrypted_message.cend(),
            encrypted_message.begin(), find_letter);

        //insert whitespace each five positions
        if (auto size = encrypted_message.size(); size > 5) {
            auto insertable_position = std::size_t{5};
            
            while (insertable_position < size) {
                encrypted_message.insert(insertable_position, " ");
                insertable_position += 6;
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
