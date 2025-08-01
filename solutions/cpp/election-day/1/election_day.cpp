#include <string>
#include <vector>
#include <algorithm>

namespace election {

// The election result struct is already created for you:

struct ElectionResult {
    // Name of the candidate
    std::string name{};
    // Number of votes the candidate has
    int votes{};
};

// TODO: Task 1
// vote_count takes a reference to an `ElectionResult` as an argument and will
// return the number of votes in the `ElectionResult.
auto vote_count(const ElectionResult& election) -> int {
    return election.votes;
}


// TODO: Task 2
// increment_vote_count takes a reference to an `ElectionResult` as an argument
// and a number of votes (int), and will increment the `ElectionResult` by that
// number of votes.
auto increment_vote_count(ElectionResult& election, int number_of_votes) -> void {
    election.votes += number_of_votes;
}

// TODO: Task 3
// determine_result receives the reference to a final_count and returns a
// reference to the `ElectionResult` of the new president. It also changes the
// name of the winner by prefixing it with "President". The final count is given
// in the form of a `reference` to `std::vector<ElectionResult>`, a vector with
// `ElectionResults` of all the participating candidates.
auto determine_result(std::vector<ElectionResult>& final_count) -> ElectionResult& {
    auto president = std::max_element(final_count.begin(), final_count.end(), 
    [] (const auto& fst, const auto& sec) {
        return fst.votes < sec.votes;
    });

    (*president).name = "President " + (*president).name;

    return *president;
}

}  // namespace election