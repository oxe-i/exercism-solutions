#include "high_scores.h"

namespace arcade {

    auto HighScores::list_scores() const -> const std::vector<int>& {
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
    
    auto HighScores::top_three() -> std::vector<int> {    
        auto list_scores = HighScores::list_scores();
        
        if (list_scores.size() < 3)
        {
            std::sort(
                list_scores.begin(),
                list_scores.end(),
                std::greater{}
            );
            return list_scores;
        }
        
        std::nth_element(
            list_scores.begin(),
            list_scores.begin() + 2,
            list_scores.end(),
            std::greater{}
        );
        
        return {list_scores.begin(), list_scores.begin() + 3};
    }

}  // namespace arcade
