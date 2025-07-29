#pragma once

#include <array>
#include <vector>
#include <algorithm>

namespace arcade {

class HighScores {
   private:
    std::vector<int> scores;

   public:
    HighScores(std::vector<int> scores) : scores{std::move(scores)}{};

    auto list_scores() const -> std::vector<int>;

    auto latest_score() const -> int;

    auto personal_best() const -> int;

    auto top_three() -> std::vector<int>;
};

}  // namespace arcade
