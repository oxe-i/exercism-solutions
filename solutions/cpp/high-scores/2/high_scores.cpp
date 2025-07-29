#include "high_scores.h"

namespace arcade {

    auto HighScores::list_scores() const -> std::vector<int> {
        return scores;
    }

    auto HighScores::latest_score() const -> int {
        return scores.back();
    }

    auto HighScores::personal_best() const -> int {
        return *(std::max_element(
            scores.begin(), 
            scores.end())
        );
    }

    //very convoluted solution to motivate study of lambda recursion
    //it is easiest to just copy the vector, sort the copy and get the last three elements by pushing_back(greatest at beginning)
    //copying and sorting everything is overkill, however, so it might be best to go lazy.
    //as ranges and views are a thing of C++20 and exercism only supports C++17 right now, a plain for loop is efficient and easier
    //to be implemented in a future iteration
    auto HighScores::top_three() -> std::vector<int> {    
        auto best_scores = std::vector<int>{scores.begin(), std::min(scores.begin() + 3, scores.end())};
        std::sort(best_scores.begin(), best_scores.end(), std::greater{});

        auto find_top_three = [&](auto&& find_top_three, auto pos) -> void {
            if (scores.begin() + pos >= scores.end())
                return;
            
            for (auto iter = scores.cbegin() + pos; iter < std::min(scores.cbegin() + pos + 3, scores.cend()); ++iter) {
                auto score_value = *iter;
                
                for (auto best_iter = best_scores.begin(); best_iter < best_scores.end(); ++best_iter) {
                    const auto current_best = *best_iter;
                    
                    if (score_value > current_best) {
                        *best_iter = score_value; 
                        score_value = current_best;
                    }
                }
            }

            find_top_three(find_top_three, pos + 3);
        };

        find_top_three(find_top_three, 3);

        return best_scores;
    }

}  // namespace arcade
