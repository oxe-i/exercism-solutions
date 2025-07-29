#if !defined(BINARY_SEARCH_H)
#define BINARY_SEARCH_H

#include <stdexcept>
#include <vector>
#include <cstddef>
#include <cstdint>

namespace binary_search {  
    auto find(const std::vector<int>& songs, const int& song_value) -> std::size_t;
}  // namespace binary_search

#endif // BINARY_SEARCH_H