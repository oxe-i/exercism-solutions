#include "largest_series_product.h"

namespace largest_series_product {
    auto largest_product(const std::string& input, int64_t span) -> uint64_t {
        if (span < 0) {
            throw std::domain_error("span is negative.");
        } 
        else if (span > static_cast<int64_t>(input.size())) {
            throw std::domain_error("span is larger than the input.");
        }
        else if (const auto invalid_character = std::find_if_not(
            input.begin(), input.end(), [] (unsigned char ch) {
                return std::isdigit(ch);
            }); invalid_character != std::end(input)) {
            throw std::domain_error("invalid character in input.");
        }

        auto partial_product = uint64_t{};
        auto range = std::string_view{input};

        for (uint64_t start {}; start < (input.size() + 1 - span); ++start) {
            partial_product = std::max(partial_product, 
                std::accumulate(range.begin() + start, range.begin() + start + span,
                uint64_t{1}, [] (uint64_t acc, char value) {
                    return acc * (value - '0');
                }));
        }

        return partial_product;
    }
} // largest_series_product