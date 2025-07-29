#include "series.h"

#include <stdexcept>

namespace series {
    auto slice(std::string_view digits, int size) -> std::vector<std::string> {
        if (size <= 0 or static_cast<unsigned>(size) > digits.size())
            throw std::domain_error("invalid size for series.");
        
        const auto num_of_slices = digits.size() - size + 1;
        auto series = std::vector<std::string>(num_of_slices);
        for (unsigned index {}; index < num_of_slices; ++index)
            series[index] = std::string{digits.begin() + index, digits.begin() + index + size};
        
        return series;
    }
}  // namespace series
