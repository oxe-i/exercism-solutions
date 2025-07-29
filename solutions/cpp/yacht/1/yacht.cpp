#include "yacht.h"

namespace yacht {
    constexpr auto are_equal(const char* first, const char* second) {
        if (*first == '\0' and *second == '\0') return true;
        if (*first == '\0' or *second == '\0' or *first != *second) return false;
        return *first == *second and are_equal(first + 1, second + 1);
    }

    constexpr auto list_of_categories = std::array{
        "ones",
        "twos",
        "threes",
        "fours",
        "fives",
        "sixes",
        "full house",
        "four of a kind",
        "little straight",
        "big straight",
        "choice",
        "yacht"
    };  

    enum class Category {
        ones,
        twos,
        threes,
        fours,
        fives,
        sixes,
        full_house,
        four_of_a_kind,
        little_straight,
        big_straight,
        choice,
        yacht
    };

    constexpr auto num_of_categories = list_of_categories.size();

    constexpr auto check_category(const char* category, std::size_t pos) -> Category {
        return pos == num_of_categories or are_equal(category, list_of_categories[pos]) ? 
                static_cast<Category>(pos) : 
                check_category(category, pos + 1);
    }

    using map_of_frequency = std::array<int, 6>;

    constexpr auto get_dice_frequency(const dice& roll) -> map_of_frequency {
        auto map = map_of_frequency{};
        for (const auto& die : roll)
            map[die - 1]++;
        return map;
    }

    auto score_function(Category category) -> std::function<int(const dice&)> {
        switch (category) {
            case Category::ones:
            case Category::twos:
            case Category::threes:
            case Category::fours:
            case Category::fives:
            case Category::sixes:
                return [multiplier = static_cast<int>(category) + 1](const dice& roll) {
                    auto sum = 0;
                    for (const auto& die : roll)
                        if (die == multiplier) sum += multiplier;
                    return sum;
                };
            case Category::full_house:
                return [] (const dice& roll) {
                    const auto frequencies = get_dice_frequency(roll);
                    auto sum = 0;
                    
                    for (auto index = 0; index < 6; ++index) {
                        const auto number = index + 1;
                        const auto frequency = frequencies[index];
                        if (frequency) {
                            if (frequency != 3 and frequency != 2) return 0;
                            sum += number * frequency;
                        }
                    }                
                    return sum;
                };
            case Category::four_of_a_kind:
                return [] (const dice& roll) {
                    const auto frequencies = get_dice_frequency(roll);
    
                    for (auto index = 0; index < 6; ++index) {
                        const auto number = index + 1;
                        const auto frequency = frequencies[index];
                        if (frequency == 4 or frequency == 5) return number * 4;
                    }
     
                    return 0;
                };
            case Category::little_straight:
                return [] (const dice& roll) {
                    const auto frequencies = get_dice_frequency(roll);
    
                    for (auto index = 0; index < 5; ++index) {
                        const auto frequency = frequencies[index];
                        if (frequency != 1) return 0;
                    }
    
                    return 30;
                };
            case Category::big_straight:
                return [] (const dice& roll) {
                    const auto frequencies = get_dice_frequency(roll);
    
                    for (auto index = 1; index < 6; ++index) {
                        const auto frequency = frequencies[index];
                        if (frequency != 1) return 0;
                    }
    
                    return 30;
                };
            case Category::choice:
                return [] (const dice& roll) {
                    return std::accumulate(
                        roll.begin(),
                        roll.end(),
                        0
                    );
                };
            default:
                return [] (const dice& roll) {
                    const auto frequencies = get_dice_frequency(roll);
                    for (const auto& frequency : frequencies)
                        if (frequency == 5) return 50;
                    return 0;
                };
        }
    }
        
    auto score(const dice& roll, const char* category_string) -> int {
        const auto category = check_category(category_string, 0);
        return score_function(category)(roll);
    }
}  // namespace yacht
