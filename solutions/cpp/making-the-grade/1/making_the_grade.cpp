#include <array>
#include <string>
#include <vector>
#include <algorithm>

// Round down all provided student scores.
std::vector<int> round_down_scores(std::vector<double> student_scores) {
    const auto size = student_scores.size();
    auto truncated_student_scores = std::vector<int>(size);

    std::transform(student_scores.cbegin(), student_scores.cend(),
        truncated_student_scores.begin(), [&] (double value) {
            return static_cast<int>(value);
        });
    
    return truncated_student_scores;
}


// Count the number of failing students out of the group provided.
int count_failed_students(std::vector<int> student_scores) {    
    return std::count_if(student_scores.begin(), student_scores.end(),
        [] (int score) {
            return score <= 40;
        });
}

// Determine how many of the provided student scores were 'the best' based on the provided threshold.
std::vector<int> above_threshold(std::vector<int> student_scores, int threshold) {
    auto highest_grades = std::vector<int>{};
    
    std::copy_if(student_scores.begin(), student_scores.end(),
        std::back_inserter(highest_grades),
        [&threshold] (int score) {
            return score >= threshold;
        });

    return highest_grades;
}

// Create a list of grade thresholds based on the provided highest grade.
std::array<int, 4> letter_grades(int highest_score) {
    auto grades = std::array<int, 4>{};
    const auto interval_range = (highest_score - 40) / 4;
    
    grades[0] = 41;
    grades[1] = grades[0] + interval_range;
    grades[2] = grades[1] + interval_range;
    grades[3] = grades[2] + interval_range;
    
    return grades;
}

// Organize the student's rank, name, and grade information in ascending order.
std::vector<std::string> student_ranking(std::vector<int> student_scores, std::vector<std::string> student_names) {
    int index {};
    
    std::transform(student_scores.cbegin(), student_scores.cend(), 
         student_names.cbegin(), student_names.begin(),
         [&index] (int score, const std::string& name) -> std::string {
             ++index;
             return std::to_string(index) + ". " +
                 name + ": " + std::to_string(score);
         });
    
    return student_names;
}

// Create a string that contains the name of the first student to make a perfect score on the exam.
std::string perfect_score(std::vector<int> student_scores, std::vector<std::string> student_names) {
    const auto pos = std::find(student_scores.begin(), student_scores.end(), 
              100);
    return pos == std::end(student_scores) ? "" :
        student_names.at(pos - std::begin(student_scores));
}
