#include "crypto_square.h"

#include <cmath>
#include <algorithm>
#include <cctype>
#include <numeric>

namespace crypto_square {

    auto find_rows_and_cols(std::size_t size) -> std::pair<std::size_t, std::size_t> {
        const std::size_t rows = std::floor(std::sqrt(size));
        const std::size_t cols = static_cast<std::size_t>(rows * rows) == size ? rows : rows + 1; 

        return {rows, cols};
    }

    auto slice(std::string text, std::size_t fragment_size) -> std::vector<std::string> {
        if (text.empty())
        {
            return std::vector<std::string>{};
        }

        auto begin = text.begin();
        auto end = text.end();

        auto fragments = std::vector<std::string>{};

        while (begin < end) 
        {
            fragments.emplace_back(
                std::string{begin, begin + fragment_size < end ? begin + fragment_size : end}
            );

            begin += fragment_size;
        }

        return fragments;
    }

    cipher::cipher(std::string text) {
        m_text = std::move(text);

        m_text = normalize_plain_text();

        m_rows_and_cols = find_rows_and_cols(m_text.size());
    }

    auto cipher::normalize_plain_text() -> std::string {
        auto text = m_text;

        text.erase(
            std::remove_if(
                text.begin(),
                text.end(),
                [](auto character)
                {
                    return std::isspace(character) or std::ispunct(character);
                }
            ),
            text.end()
        );

        std::transform(
            text.cbegin(),
            text.cend(),
            text.begin(),
            [](auto character)
            {
                return std::isalpha(character) ? std::tolower(character) : character;
            }
        );

        return text;
    }
    
    auto cipher::plain_text_segments() -> std::vector<std::string> {
        return slice(m_text, m_rows_and_cols.second);
    }

    auto cipher::cipher_text() -> std::string {
        auto ciphered_text = std::string{};

        auto fragments = plain_text_segments();

        if (fragments.empty())
        {
            return ciphered_text;
        }

        for (std::size_t row_index{}; row_index < m_rows_and_cols.second; ++row_index) 
        {
            for (std::size_t fragment_index{}; fragment_index < fragments.size(); ++fragment_index) 
            {
                if (row_index < fragments.at(fragment_index).size()) 
                {
                    ciphered_text += fragments.at(fragment_index).at(row_index);
                }
            }
        }

        return ciphered_text;
    }

    auto cipher::normalized_cipher_text() -> std::string {
        auto fragments_of_ciphered_text = slice(cipher_text(), m_rows_and_cols.first);

        if (fragments_of_ciphered_text.empty())
        {
            return std::string{};
        }

        const auto number_of_fragments_to_be_padded = (m_rows_and_cols.first * m_rows_and_cols.second) - m_text.size();

        const auto fragments_to_be_padded = std::accumulate(
                                        fragments_of_ciphered_text.end() - number_of_fragments_to_be_padded,
                                        fragments_of_ciphered_text.end(),
                                        std::string{},
                                        [](auto&& acc, auto&& value) {
                                            return acc + value;
                                        }
                                    );

        std::for_each(
            fragments_of_ciphered_text.end() - number_of_fragments_to_be_padded,
            fragments_of_ciphered_text.end(),
            [begin = fragments_to_be_padded.begin(), size = m_rows_and_cols.first - 1](auto&& val) mutable
            {
                val = std::string{begin, begin + size} + " ";

                begin += size;
            }
        );

        return std::accumulate(
                    fragments_of_ciphered_text.begin() + 1,
                    fragments_of_ciphered_text.end(),
                    std::string{fragments_of_ciphered_text.front()},
                    [](auto&& acc, auto&& fragment)
                    {
                        return acc + " " + fragment;
                    }
                );
    }
}  // namespace crypto_square
