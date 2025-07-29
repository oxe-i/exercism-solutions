#include "binary_search.h"

namespace binary_search {

    auto find(const std::vector<int>& songs, const int& song_value) -> std::size_t {
        if (songs.empty()) {
            throw std::domain_error("there isn't any song");
        }
        
        auto low = static_cast<int64_t>(0);
        auto high = static_cast<int64_t>(songs.size() - 1);

        while (low <= high) {
            const auto mid = (low + high) >> 1;

            if (songs[mid] == song_value) {
                return mid;
            }
            else if (songs[mid] > song_value) {
                high = mid - 1;
            }
            else {
                low = mid + 1;
            }
        }

        throw std::domain_error("there's no song for that value");
        
    }
}  // namespace binary_search
