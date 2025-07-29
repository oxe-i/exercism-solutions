#include "series.h"

namespace series {

    auto slice(const std::string& sequence, int64_t number) -> std::vector<std::string> {
        const auto size = static_cast<int64_t>(sequence.size());
        
        if (number < 1 or number > size) {
            throw std::domain_error("invalid parameter");
        }
        
        auto slices = std::vector<std::string>{};
        const auto num_of_slices = size + 1 - number;

        std::transform(sequence.cbegin(), sequence.cbegin() + num_of_slices, std::back_inserter(slices),
            [&] (const char& elem) {
                auto pos = &elem;
                
                return std::string{pos, pos + number};
            });
        
        return slices;
    }

}  // namespace series
