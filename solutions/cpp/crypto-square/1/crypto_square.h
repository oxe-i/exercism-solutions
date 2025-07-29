#if !defined(CRYPTO_SQUARE_H)
#define CRYPTO_SQUARE_H

#include <string>
#include <vector>
#include <cstddef>

namespace crypto_square {
    class cipher {
    private:
        std::string m_text;
        std::pair<std::size_t, std::size_t> m_rows_and_cols;
    public:
        cipher(std::string text); 
        auto normalize_plain_text() -> std::string;
        auto plain_text_segments() -> std::vector<std::string>;
        auto cipher_text() -> std::string;
        auto normalized_cipher_text() -> std::string;
    };
}  // namespace crypto_square

#endif // CRYPTO_SQUARE_H