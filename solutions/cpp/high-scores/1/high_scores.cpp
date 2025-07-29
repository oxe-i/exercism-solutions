#include "high_scores.h"

namespace arcade {

    const std::vector<int> HighScores::list_scores() {
        // TODO: Return all scores for this session.
        return scores;
    }

    int HighScores::latest_score() {
        // TODO: Return the latest score for this session.
        return scores.back();
    }

    int HighScores::personal_best() {
        // TODO: Return the highest score for this session.
        return *(std::max_element(
            scores.begin(), scores.end()));
    }

    std::vector<int> HighScores::top_three() {
        // TODO: Return the top 3 scores for this session in descending order.     
        auto list_scores{scores};
        
        std::sort(
             list_scores.begin(), list_scores.end());

        const int num = list_scores.size() >= 3 ? 
                          3 : list_scores.size();

        auto top_three = std::vector<int>{
             list_scores.end() - num,
             list_scores.end()
        };
            
        std::reverse(
             top_three.begin(), top_three.end());

        return top_three;
    }

}  // namespace arcade
