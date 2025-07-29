#if !defined(CRYPTO_SQUARE_H)
#define CRYPTO_SQUARE_H

#include <string_view>
#include <string>
#include <cmath>
#include <cctype>
#include <ranges>

namespace crypto_square {
    class cipher {
    private:
        std::string_view m_text;
    public:
        constexpr cipher(std::string_view);
        //constexpr std::string require C++20 and is available in GCC 12.1
        constexpr auto normalized_cipher_text() -> std::string; 
    };

    constexpr cipher::cipher(std::string_view text) : m_text{text} {}

    //ranges (and view adaptors inside ranges library) require C++20
    using namespace std::ranges;
    using namespace std::views; 

    constexpr auto get_dimensions(size_t size) -> std::pair<size_t, size_t>
    {
        const auto root = static_cast<size_t>(std::sqrt(size));
        if (root * root == size) return {root, root};
        if (root * (root + 1) >= size) return {root, root + 1};
        return {root + 1, root + 1};
    }

    constexpr auto cipher::normalized_cipher_text() -> std::string
    {
        //std::views::filter and std::views::transform require C++20 and are available in GCC 10.1 (I believe)
        //std::ranges::to require C++23 and is available in GCC 14.1
        auto normalized_text =  m_text
                            |   filter([](char letter) -> bool { return not std::isspace(letter) and not std::ispunct(letter); })
                            |   transform([](char letter) -> char { return std::tolower(letter); })
                            |   to<std::string>();

        const auto size = normalized_text.size();
        const auto [rows, cols] = get_dimensions(size);

        //there's a std::views::concat which serve this same purpose, but it requires C++26 
        //and isn't currently available in any GCC version
        if (const auto mult = rows * cols; mult != size) for ([[maybe_unused]] auto i : iota(size, mult)) normalized_text.push_back(' ');
        
        //std::views::join_with and std::views::stride require C++23 and are available in GCC 13.1
        return  iota(size_t{0}, cols) | transform([=](size_t x) { return normalized_text | drop(x) | stride(cols); }) //transpose (of a flattened matrix)
            |   join_with(' ')
            |   to<std::string>();
    }

}  // namespace crypto_square

#endif // CRYPTO_SQUARE_H