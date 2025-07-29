#include "rotational_cipher.h"

#include <cctype>

namespace rotational_cipher {
    auto rotate(const char* plain, int rotation) -> std::string
    {
        if (plain[0] == '\0') return std::string{};
        if (std::isupper(plain[0])) 
            return static_cast<char>('A' + (plain[0] - 'A' + rotation) % 26) + 
                rotate(&plain[1], rotation);             
        if (std::islower(plain[0]))
            return static_cast<char>('a' + (plain[0] - 'a' + rotation) % 26) + 
                rotate(&plain[1], rotation);
        return std::string{plain[0]} + rotate(&plain[1], rotation);
    }
}  // namespace rotational_cipher
