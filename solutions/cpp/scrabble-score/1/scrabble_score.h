#if !defined(SCRABBLE_SCORE_H)
#define SCRABBLE_SCORE_H

#include <cstdint>
#include <string>
#include <array>
#include <numeric>
#include <functional>

namespace scrabble_score {
   auto score(const std::string& word) -> uint64_t;
}  // namespace scrabble_score

#endif // SCRABBLE_SCORE_H